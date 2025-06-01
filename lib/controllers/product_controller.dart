import '../models/product.dart';

class ProductController {
  List<Product> getProducts() {
    return [
      Product(
        imageUrl: 'assets/images/user.png',
        title: 'Grinder',
        quantity: 24,
        price: 65.00,
        isNew: true,
      ),
      Product(
        imageUrl: 'assets/images/user.png',
        title: 'Kettle',
        quantity: 12,
        price: 65.00,
      ),
    ];
  }
}
