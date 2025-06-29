import 'package:flutter/material.dart';

class Pharmacy {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;
  final bool isOpen;
  final double rating;
  final String imageUrl;
  final List<String> services;

  Pharmacy({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.isOpen,
    required this.rating,
    required this.imageUrl,
    required this.services,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isSponsored;
  final String pharmacyId;
  final int stock;
  final double rating;
  final List<String> benefits;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isSponsored,
    required this.pharmacyId,
    required this.stock,
    required this.rating,
    required this.benefits,
  });
}

class PharmacyProvider with ChangeNotifier {
  final List<Pharmacy> _pharmacies = [
    Pharmacy(
      id: '1',
      name: 'City Pharmacy',
      address: '123 Main St, Tunis',
      latitude: 36.8065,
      longitude: 10.1815,
      phone: '+216 12345678',
      isOpen: true,
      rating: 4.5,
      imageUrl: 'assets/images/pharmacy1.jpg',
      services: ['Prescription', 'Vaccination', 'Delivery'],
    ),
    Pharmacy(
      id: '2',
      name: 'Health Plus',
      address: '456 Avenue Habib Bourguiba, Tunis',
      latitude: 36.7989,
      longitude: 10.1755,
      phone: '+216 98765432',
      isOpen: true,
      rating: 4.2,
      imageUrl: 'assets/images/pharmacy2.jpg',
      services: ['Prescription', 'Vaccination', 'Home Delivery'],
    ),
    Pharmacy(
      id: '3',
      name: 'MediCare',
      address: '789 Rue de la Paix, Tunis',
      latitude: 36.8123,
      longitude: 10.1698,
      phone: '+216 45678901',
      isOpen: false,
      rating: 4.0,
      imageUrl: 'assets/images/pharmacy3.jpg',
      services: ['Prescription', 'Vaccination', '24/7 Service'],
    ),
  ];

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Vitamin C 1000mg',
      description: 'High-strength vitamin C supplement for immune support',
      price: 15.99,
      imageUrl: 'assets/images/vitamin_c.jpg',
      category: 'Vitamins',
      isSponsored: true,
      pharmacyId: '1',
      stock: 50,
      rating: 4.5,
      benefits: ['Immune Support', 'Antioxidant', 'Collagen Production'],
    ),
    Product(
      id: '2',
      name: 'Omega-3 Fish Oil',
      description: 'Pure fish oil supplement for heart and brain health',
      price: 24.99,
      imageUrl: 'assets/images/omega3.jpg',
      category: 'Supplements',
      isSponsored: true,
      pharmacyId: '2',
      stock: 30,
      rating: 4.3,
      benefits: ['Heart Health', 'Brain Function', 'Joint Support'],
    ),
    Product(
      id: '3',
      name: 'Probiotic Complex',
      description: 'Advanced probiotic formula for gut health',
      price: 29.99,
      imageUrl: 'assets/images/probiotic.jpg',
      category: 'Supplements',
      isSponsored: true,
      pharmacyId: '3',
      stock: 25,
      rating: 4.7,
      benefits: ['Gut Health', 'Digestive Support', 'Immune System'],
    ),
  ];

  final Set<String> _cartItems = {};

  List<Pharmacy> get pharmacies => [..._pharmacies];
  List<Product> get products => [..._products];
  List<Product> get sponsoredProducts =>
      _products.where((p) => p.isSponsored).toList();
  Set<String> get cartItems => {..._cartItems};

  List<Pharmacy> searchPharmacies(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _pharmacies.where((pharmacy) {
      return pharmacy.name.toLowerCase().contains(lowercaseQuery) ||
          pharmacy.address.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Product> searchProducts(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
          product.description.toLowerCase().contains(lowercaseQuery) ||
          product.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Pharmacy> getNearbyPharmacies(
      double latitude, double longitude, double radius) {
    // Simple distance calculation (you might want to use a more sophisticated algorithm)
    return _pharmacies.where((pharmacy) {
      final distance = _calculateDistance(
        latitude,
        longitude,
        pharmacy.latitude,
        pharmacy.longitude,
      );
      return distance <= radius;
    }).toList();
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    // Simple Euclidean distance (you might want to use Haversine formula for more accuracy)
    return ((lat1 - lat2) * (lat1 - lat2) + (lon1 - lon2) * (lon1 - lon2))
        .abs();
  }

  void addToCart(String productId) {
    _cartItems.add(productId);
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }
}
