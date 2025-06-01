class Product {
  final String imageUrl;
  final String title;
  final int quantity;
  final double price;
  final bool isNew;
  int selectedQuantity;

  Product({
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
    this.isNew = false,
    this.selectedQuantity = 1,
  });

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
    'quantity': quantity,
    'price': price,
    'isNew': isNew,
    'selectedQuantity': selectedQuantity,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    imageUrl: json['imageUrl'],
    title: json['title'],
    quantity: json['quantity'],
    price: json['price'],
    isNew: json['isNew'] ?? false,
    selectedQuantity: json['selectedQuantity'] ?? 1,
  );
}
