import 'package:flutter/material.dart';
import 'package:frontend_wepay/controllers/product_controller.dart';
import 'package:frontend_wepay/screens/integrated/nav_pages/product_card.dart';
import 'package:frontend_wepay/services/local_storage.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class NavProductPage extends StatelessWidget {
  final controller = ProductController();

  NavProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = controller.getProducts();

    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    "Made for you",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
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

              // Liste horizontale des produits
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 12),
                      child: ProductCard(
                        product: product,
                        onAdd: () async {
                          // Ajouter le produit localement
                          final savedProducts = await LocalStorage.getProducts();
                          savedProducts.add(product);
                          await LocalStorage.saveProducts(savedProducts);

                          // Afficher une snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.title} added to cart')),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
