import 'package:flutter/material.dart';
import 'package:frontend_wepay/models/product.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Largeur fixe pour scroll horizontal
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // INFOS DU PRODUIT
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ÉTIQUETTE NOUVEAU
                  if (product.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  const SizedBox(height: 4),

                  // TITRE
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // QUANTITÉ EN STOCK
                  Text(
                    '${product.quantity} in stock',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  // PRIX
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  // BOUTON AJOUTER
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onAdd,
                      icon: const Icon(Icons.shopping_cart, size: 16),
                      label: const Text("Add"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
