import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_wepay/models/product.dart';

class LocalStorage {
  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList =
        products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList('products', productList);
  }

  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? productList = prefs.getStringList('products');
    if (productList == null) return [];
    return productList
        .map((productJson) => Product.fromJson(jsonDecode(productJson)))
        .toList();
  }

  static Future<void> deleteProductByTitle(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? productList = prefs.getStringList('products');
    if (productList == null) return;

    List<Product> products = productList
        .map((productJson) => Product.fromJson(jsonDecode(productJson)))
        .toList();

    products.removeWhere((product) => product.title == title);

    List<String> updatedList =
        products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('products', updatedList);
  }
}
