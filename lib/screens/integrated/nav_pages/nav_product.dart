import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_wepay/controllers/product_controller.dart';
import 'package:frontend_wepay/screens/integrated/nav_pages/product_card.dart';
import 'package:frontend_wepay/services/local_storage.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';
import 'package:uuid/uuid.dart';

import '../../../models/product.dart';

class NavProductPage extends StatefulWidget {
  const NavProductPage({super.key});

  @override
  State<NavProductPage> createState() => _NavProductPageState();
}

class _NavProductPageState extends State<NavProductPage> {
  final controller = ProductController();
  late Future<List<Product>> _productsFuture;
  List<Product> _currentProducts = []; // Track current products locally

  late List<TextEditingController> _labelControllers;
  late List<TextEditingController> _pathControllers;
  late List<TextEditingController> _paramKeyControllers;
  late List<TextEditingController> _paramValueControllers;
  late List<TextEditingController> _jsonBodyControllers;
  late List<String?> _selectedMethods;
  List<String?> _selectedServiceTypes = [];

  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _productsFuture = Future.value([]); // Initialize with empty list
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getsaved();
    if (_selectedServiceTypes.contains('Load item')) {
      await _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    final products = await controller.getProducts(context);
    setState(() {
      _currentProducts = products;
      _productsFuture = Future.value(products);
    });
  }

  Future<void> getsaved() async {
    final String? jsonString = await _storage.read(key: 'services_data');

    if (jsonString != null) {
      final List<dynamic> decodedList = json.decode(jsonString);
      final List<ServiceData> services = decodedList
          .map((item) => ServiceData.fromJson(item as Map<String, dynamic>))
          .toList();

      setState(() {
        _labelControllers = services.map((s) => TextEditingController(text: s.label)).toList();
        _pathControllers = services.map((s) => TextEditingController(text: s.path)).toList();
        _paramKeyControllers = services.map((s) => TextEditingController(text: s.paramKey)).toList();
        _paramValueControllers = services.map((s) => TextEditingController(text: s.paramValue)).toList();
        _jsonBodyControllers = services.map((s) => TextEditingController(text: s.jsonBody)).toList();
        _selectedMethods = services.map((s) => s.method).toList();
        _selectedServiceTypes = services.map((s) => s.serviceType).toList();
      });
    }
  }

  Future<void> _deleteProduct(Product product) async {
    try {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${product.title}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      ) ?? false;

      if (!confirmDelete) return;

      // Update local state immediately
      setState(() {
        _currentProducts.removeWhere((p) => p.id == product.id);
        _productsFuture = Future.value(_currentProducts);
      });

      // Update storage
      final savedProducts = await LocalStorage.getProducts();
      savedProducts.removeWhere((p) => p.id == product.id);
      await LocalStorage.saveProducts(savedProducts);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.title} removed successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove product: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showEditDialog(Product product) async {
    final titleController = TextEditingController(text: product.title);
    final descriptionController = TextEditingController(text: product.description);
    final priceController = TextEditingController(text: product.price.toString());
    final imageController = TextEditingController(text: product.imageUrl);
    final categoryController = TextEditingController(text: product.category);
    final rateController = TextEditingController(text: product.rating.rate.toString());
    final countController = TextEditingController(text: product.rating.count.toString());
    final quantityController = TextEditingController(text: product.quantity.toString());

    String? selectedCategory = product.category;
    List<String> categories = [
      'electronics',
      'jewelery',
      "men's clothing",
      "women's clothing"
    ];

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedCategory = newValue;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: rateController,
                decoration: const InputDecoration(
                  labelText: 'Rating (0-5)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: countController,
                decoration: const InputDecoration(
                  labelText: 'Review Count',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  priceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all required fields'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final updatedProduct = Product(
                id: product.id,
                imageUrl: imageController.text,
                title: titleController.text,
                description: descriptionController.text,
                price: double.tryParse(priceController.text) ?? product.price,
                quantity: int.tryParse(quantityController.text) ?? product.quantity,
                isNew: product.isNew,
                selectedQuantity: product.selectedQuantity,
                category: selectedCategory ?? categoryController.text,
                rating: Rating(
                  rate: double.tryParse(rateController.text) ?? product.rating.rate,
                  count: int.tryParse(countController.text) ?? product.rating.count,
                ),
              );

              try {
                // Update local state immediately
                setState(() {
                  final index = _currentProducts.indexWhere((p) => p.id == product.id);
                  if (index != -1) {
                    _currentProducts[index] = updatedProduct;
                  }
                  _productsFuture = Future.value(_currentProducts);
                });

                // Update storage
                final savedProducts = await LocalStorage.getProducts();
                final index = savedProducts.indexWhere((p) => p.id == product.id);
                if (index != -1) {
                  savedProducts[index] = updatedProduct;
                  await LocalStorage.saveProducts(savedProducts);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${updatedProduct.title} updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to update product: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.kPrimaryColor,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog() async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final imageController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    final rateController = TextEditingController(text: '0');
    final countController = TextEditingController(text: '0');

    String? selectedCategory;
    List<String> categories = [
      'electronics',
      'jewelery',
      "men's clothing",
      "women's clothing"
    ];

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title*',
                  border: OutlineInputBorder(),
                  hintText: 'Product name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description*',
                  border: OutlineInputBorder(),
                  hintText: 'Product description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category*',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedCategory = newValue;
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price*',
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                  hintText: '1',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: rateController,
                decoration: const InputDecoration(
                  labelText: 'Rating (0-5)',
                  border: OutlineInputBorder(),
                  hintText: '0',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: countController,
                decoration: const InputDecoration(
                  labelText: 'Review Count',
                  border: OutlineInputBorder(),
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  priceController.text.isEmpty ||
                  selectedCategory == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all required fields (*)'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final newProduct = Product(
                id: int.parse(Uuid() as String), // Using timestamp as ID
                imageUrl: imageController.text.isNotEmpty
                    ? imageController.text
                    : 'https://via.placeholder.com/150',
                title: titleController.text,
                description: descriptionController.text,
                price: double.tryParse(priceController.text) ?? 0,
                quantity: int.tryParse(quantityController.text) ?? 1,
                isNew: true,
                selectedQuantity: 0,
                category: selectedCategory!,
                rating: Rating(
                  rate: double.tryParse(rateController.text) ?? 0,
                  count: int.tryParse(countController.text) ?? 0,
                ),
              );

              try {
                // Update local state immediately
                setState(() {
                  // _currentProducts.add(newProduct);
                  _currentProducts.insert(0, newProduct);
                  _productsFuture = Future.value(_currentProducts);
                });

                // Add to storage
                final savedProducts = await LocalStorage.getProducts();
                savedProducts.insert(0, newProduct);
                // savedProducts.add(newProduct);
                await LocalStorage.saveProducts(savedProducts);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${newProduct.title} added successfully'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to add product: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.kPrimaryColor,
            ),
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Made for you",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _showAddDialog,
                    icon: const Icon(CupertinoIcons.add_circled_solid),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.replay_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Product>>(
                future: _productsFuture,

                builder: (context, snapshot) {
                  if (_selectedServiceTypes.contains('Load item')) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No products available'));
                    }

                    final products = snapshot.data!;

                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height/1,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10, // Horizontal spacing between items
                          mainAxisSpacing: 10, // Vertical spacing between items
                          childAspectRatio: 1, // Aspect ratio of each item (width/height)
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Container(
                            width: 220,
                            margin: const EdgeInsets.only(right: 12),
                            child: ProductCard(
                              product: product,
                              onAdd: () async {
                                final savedProducts = await LocalStorage.getProducts();
                                savedProducts.insert(0, product);
                                savedProducts.insert(savedProducts.length, product);
                                final lastProduct = savedProducts.removeLast(); // Remove and get the last item
                                savedProducts.insert(0, lastProduct);
                                await LocalStorage.saveProducts(savedProducts);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${product.title} added to cart')),
                                );
                              },
                              onDelete: () => _deleteProduct(product),
                              onEdit: () => _showEditDialog(product),
                              showedit: _selectedServiceTypes.contains('Configure item'),
                              showdelete: _selectedServiceTypes.contains('Remove item'),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (_selectedServiceTypes.contains('Remove item') || _selectedServiceTypes.contains('Configure item')) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).width / 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'Load or create an item to proceed',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: Column(
                              children: [
                                if (_selectedServiceTypes.contains('Remove item'))
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.trash, size: 16),
                                    label: const Text('Remove item'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TColors.kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      textStyle: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                if (_selectedServiceTypes.contains('Remove item') && _selectedServiceTypes.contains('Configure item'))
                                  const SizedBox(height: 12),
                                if (_selectedServiceTypes.contains('Configure item'))
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.gear, size: 16),
                                    label: const Text('Configure item'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TColors.kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      textStyle: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (_selectedServiceTypes.contains('Save new item')) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).width / 1.5),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: ElevatedButton.icon(
                            onPressed: _showAddDialog,
                            icon: const Icon(CupertinoIcons.add_circled_solid, size: 16),
                            label: const Text("Add new item"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No service selected'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}