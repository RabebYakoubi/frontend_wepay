import 'package:flutter/material.dart';
import 'package:frontend_wepay/models/product.dart';



class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productModel,
    required this.onIncrement,
    required this.onDecrement,
  });

  final Product productModel;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Image.asset(productModel.imageUrl, fit: BoxFit.cover, width: 60),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${productModel.price.toStringAsFixed(2)} TND",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onDecrement,
              ),
              Text(productModel.selectedQuantity.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
