import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/constants/apifetch.dart';
import '../utils/constants/save.dart';

class ProductController {
  final TextEditingController _labelleController = TextEditingController();
  String? _selectedType;
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _nbserviceController = TextEditingController();
  String? _selectedSecurityType;
  late List<TextEditingController> _labelControllers;
  late List<TextEditingController> _pathControllers;
  late List<TextEditingController> _paramKeyControllers;
  late List<TextEditingController> _paramValueControllers;
  late List<TextEditingController> _jsonBodyControllers;
  late List<String?> _selectedMethods;
  late List<String?> _selectedServiceTypes;

  Future<List<Product>> getProducts(BuildContext context) async {
    print('Fetching products...');
    try {
      final _storage = FlutterSecureStorage();

      // Load basic configuration
      _labelleController.text = await SecureStorageHelper.get('labelle') ?? 'Rabeb';
      _selectedType = await SecureStorageHelper.get('type') ?? 'Rest';
      _urlController.text = await SecureStorageHelper.get('url') ?? 'https://fakestoreapi.com/';
      _nbserviceController.text = await SecureStorageHelper.get('nbservice') ?? '1';
      _selectedSecurityType = await SecureStorageHelper.get('securityType') ?? 'JWT';

      // Load services data
      final String? jsonString = await _storage.read(key: 'services_data');
      if (jsonString == null || jsonString.isEmpty) {
        throw Exception('No services data found');
      }

      // Parse JSON and filter services with 'Load item'
      final List<dynamic> decodedList = json.decode(jsonString);
      final List<ServiceData> allServices = decodedList
          .map((item) => ServiceData.fromJson(item as Map<String, dynamic>))
          .toList();

      // Filter services to only those with 'Load item' service type
      final List<ServiceData> loadItemServices = allServices
          .where((service) => service.serviceType == 'Load item')
          .toList();

      if (loadItemServices.isEmpty) {
        throw Exception('No services with "Load item" type found');
      }

      // Rebuild controllers/lists only for Load item services
      _labelControllers = loadItemServices.map((s) => TextEditingController(text: s.label)).toList();
      _pathControllers = loadItemServices.map((s) => TextEditingController(text: s.path)).toList();
      _paramKeyControllers = loadItemServices.map((s) => TextEditingController(text: s.paramKey)).toList();
      _paramValueControllers = loadItemServices.map((s) => TextEditingController(text: s.paramValue)).toList();
      _jsonBodyControllers = loadItemServices.map((s) => TextEditingController(text: s.jsonBody)).toList();
      _selectedMethods = loadItemServices.map((s) => s.method).toList();
      _selectedServiceTypes = loadItemServices.map((s) => s.serviceType).toList();

      // Use the first Load item service to fetch products
      final ServiceData loadItemService = loadItemServices.first;
      print('Using service: ${loadItemService.path} with method: ${loadItemService.method}');

      final response = await fetchApiWithStyledDialog(
        context: context,
        url: '${_urlController.text}${loadItemService.path}',
        method: loadItemService.method ?? 'GET', // Default to GET if method is null
        loadingMessage: 'Loading products...',
      );

      print('API response: ${response.toString()}');

      if (response != null && response is List) {
        return response.map((productJson) => Product.fromJson(productJson)).toList();
      } else {
        return []; // Return empty list if no products or error occurs
      }
    } catch (e) {
      print('Error fetching products: $e');
      // Fallback dummy data
      return [
        Product(
          imageUrl: 'assets/images/user.png',
          title: 'Grinder',
          quantity: 24,
          price: 65.00,
          isNew: true,
          id: 5,
          description: 'Sample product',
          category: 'tools',
          rating: Rating(rate: 5, count: 3),
        ),
      ];
    }
  }

  void dispose() {
    _labelleController.dispose();
    _urlController.dispose();
    _nbserviceController.dispose();
    for (var controller in _labelControllers) { controller.dispose(); }
    for (var controller in _pathControllers) { controller.dispose(); }
    for (var controller in _paramKeyControllers) { controller.dispose(); }
    for (var controller in _paramValueControllers) { controller.dispose(); }
    for (var controller in _jsonBodyControllers) { controller.dispose(); }
  }
}

class ServiceData {
  final String label;
  final String path;
  final String paramKey;
  final String paramValue;
  final String jsonBody;
  final String? method;
  final String? serviceType;

  ServiceData({
    required this.label,
    required this.path,
    required this.paramKey,
    required this.paramValue,
    required this.jsonBody,
    this.method,
    this.serviceType,
  });

  Map<String, dynamic> toJson() => {
    'label': label,
    'path': path,
    'paramKey': paramKey,
    'paramValue': paramValue,
    'jsonBody': jsonBody,
    'method': method,
    'serviceType': serviceType,
  };

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    label: json['label'],
    path: json['path'],
    paramKey: json['paramKey'],
    paramValue: json['paramValue'],
    jsonBody: json['jsonBody'],
    method: json['method'],
    serviceType: json['serviceType'],
  );
}