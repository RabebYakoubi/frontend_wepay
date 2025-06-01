import 'package:flutter/material.dart';
import 'package:frontend_wepay/models/product.dart';
import 'package:frontend_wepay/services/local_storage.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class NavPanierPage extends StatefulWidget {
  const NavPanierPage({super.key});

  @override
  State<NavPanierPage> createState() => _NavPanierPageState();
}

class _NavPanierPageState extends State<NavPanierPage> {
  List<Product> _products = [];

  Future<void> _loadProducts() async {
    List<Product> products = await LocalStorage.getProducts();
    setState(() {
      _products = products;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      body: _products.isEmpty
          ? const Center(
              child: Text(
                "Votre panier est vide",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: _products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final product = _products[index];

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(product.imageUrl, width: 60, height: 60),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "${product.price.toStringAsFixed(2)} TND",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () async {
                              setState(() {
                                if (product.selectedQuantity > 1) {
                                  product.selectedQuantity--;
                                } else {
                                  _products.removeAt(index);
                                }
                              });
                              await LocalStorage.saveProducts(_products);
                            },
                          ),
                          Text(product.selectedQuantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              setState(() {
                                product.selectedQuantity++;
                              });
                              await LocalStorage.saveProducts(_products);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
