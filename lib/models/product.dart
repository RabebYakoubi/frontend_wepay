class Product {
  final String imageUrl;  // Maps to API's "image"
  final String title;     // Same as API
  final int quantity;     // Not in API - keeping your existing field
  final double price;     // Same as API
  final bool isNew;       // Not in API - keeping your existing field
  final int id;           // New from API
  final String description; // New from API
  final String category;    // New from API
  final Rating rating;      // New from API
  int selectedQuantity;     // Your existing field

  Product({
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
    this.isNew = false,
    this.selectedQuantity = 1,
    required this.id,
    required this.description,
    required this.category,
    required this.rating,
  });

  // Convert to JSON - keeping your original field names and adding new ones
  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
    'quantity': quantity,
    'price': price,
    'isNew': isNew,
    'selectedQuantity': selectedQuantity,
    'id': id,
    'description': description,
    'category': category,
    'rating': rating.toJson(),
  };

  // Create from JSON - mapping API fields to your field names
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageUrl: json['image'] as String? ?? '',  // Map API's 'image' to 'imageUrl'
      title: json['title'] as String? ?? 'No Title',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: 0,  // Default since not in API
      isNew: false, // Default since not in API
      selectedQuantity: 1, // Default since not in API
      id: json['id'] as int? ?? 0,
      description: json['description'] as String? ?? 'No Description',
      category: json['category'] as String? ?? 'Uncategorized',
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toJson() => {
    'rate': rate,
    'count': count,
  };

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] as int? ?? 0,
    );
  }
}