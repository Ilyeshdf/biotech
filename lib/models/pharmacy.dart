import 'package:flutter/foundation.dart';

@immutable
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
  final String? website;
  final String? email;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BusinessHours> businessHours;
  final List<String> acceptedInsurance;
  final bool hasDelivery;
  final bool hasDriveThru;
  final double? deliveryFee;
  final int? deliveryTime; // in minutes
  final List<String> specialties;
  final String? licenseNumber;
  final String? pharmacistName;

  const Pharmacy({
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
    this.website,
    this.email,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.businessHours,
    required this.acceptedInsurance,
    required this.hasDelivery,
    required this.hasDriveThru,
    this.deliveryFee,
    this.deliveryTime,
    required this.specialties,
    this.licenseNumber,
    this.pharmacistName,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phone: json['phone'] as String,
      isOpen: json['isOpen'] as bool,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      services: List<String>.from(json['services'] ?? []),
      website: json['website'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      businessHours: (json['businessHours'] as List?)
              ?.map((hours) => BusinessHours.fromJson(hours))
              .toList() ??
          [],
      acceptedInsurance: List<String>.from(json['acceptedInsurance'] ?? []),
      hasDelivery: json['hasDelivery'] as bool? ?? false,
      hasDriveThru: json['hasDriveThru'] as bool? ?? false,
      deliveryFee: json['deliveryFee'] != null
          ? (json['deliveryFee'] as num).toDouble()
          : null,
      deliveryTime: json['deliveryTime'] as int?,
      specialties: List<String>.from(json['specialties'] ?? []),
      licenseNumber: json['licenseNumber'] as String?,
      pharmacistName: json['pharmacistName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'isOpen': isOpen,
      'rating': rating,
      'imageUrl': imageUrl,
      'services': services,
      'website': website,
      'email': email,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'businessHours': businessHours.map((hours) => hours.toJson()).toList(),
      'acceptedInsurance': acceptedInsurance,
      'hasDelivery': hasDelivery,
      'hasDriveThru': hasDriveThru,
      'deliveryFee': deliveryFee,
      'deliveryTime': deliveryTime,
      'specialties': specialties,
      'licenseNumber': licenseNumber,
      'pharmacistName': pharmacistName,
    };
  }

  Pharmacy copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? phone,
    bool? isOpen,
    double? rating,
    String? imageUrl,
    List<String>? services,
    String? website,
    String? email,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<BusinessHours>? businessHours,
    List<String>? acceptedInsurance,
    bool? hasDelivery,
    bool? hasDriveThru,
    double? deliveryFee,
    int? deliveryTime,
    List<String>? specialties,
    String? licenseNumber,
    String? pharmacistName,
  }) {
    return Pharmacy(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      isOpen: isOpen ?? this.isOpen,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      services: services ?? this.services,
      website: website ?? this.website,
      email: email ?? this.email,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      businessHours: businessHours ?? this.businessHours,
      acceptedInsurance: acceptedInsurance ?? this.acceptedInsurance,
      hasDelivery: hasDelivery ?? this.hasDelivery,
      hasDriveThru: hasDriveThru ?? this.hasDriveThru,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      specialties: specialties ?? this.specialties,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      pharmacistName: pharmacistName ?? this.pharmacistName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pharmacy && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Pharmacy(id: $id, name: $name, isOpen: $isOpen)';
  }

  // Helper methods
  bool get isHighlyRated => rating >= 4.0;
  bool get isWellRated => rating >= 3.5;
  bool get hasGoodServices => services.length >= 3;
  bool get is24Hours => businessHours.any((hours) => hours.is24Hours);
  bool get hasInsurance => acceptedInsurance.isNotEmpty;

  String get statusText {
    if (isOpen) return 'Open Now';
    return 'Closed';
  }

  String get statusColor {
    return isOpen ? '#4CAF50' : '#F44336';
  }

  String get ratingText {
    return '${rating.toStringAsFixed(1)} ★';
  }

  String get deliveryInfo {
    if (!hasDelivery) return 'No delivery';
    if (deliveryFee == null) return 'Free delivery';
    return '\$${deliveryFee!.toStringAsFixed(2)} delivery';
  }

  String get deliveryTimeText {
    if (!hasDelivery || deliveryTime == null) return '';
    if (deliveryTime! < 60) return '${deliveryTime}min';
    final hours = deliveryTime! ~/ 60;
    final minutes = deliveryTime! % 60;
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }

  List<String> get availableServices {
    return services.where((service) => service.isNotEmpty).toList();
  }

  bool hasService(String service) {
    return services.any((s) => s.toLowerCase().contains(service.toLowerCase()));
  }

  bool acceptsInsurance(String insurance) {
    return acceptedInsurance
        .any((i) => i.toLowerCase().contains(insurance.toLowerCase()));
  }
}

@immutable
class BusinessHours {
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  const BusinessHours({
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
      day: json['day'] as String,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
      isClosed: json['isClosed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'openTime': openTime,
      'closeTime': closeTime,
      'isClosed': isClosed,
    };
  }

  bool get is24Hours => openTime == '00:00' && closeTime == '23:59';
  String get formattedHours => isClosed ? 'Closed' : '$openTime - $closeTime';
}

@immutable
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
  final String? genericName;
  final String? brandName;
  final String? dosage;
  final String? strength;
  final bool requiresPrescription;
  final bool isOverTheCounter;
  final List<String> sideEffects;
  final List<String> contraindications;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
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
    this.genericName,
    this.brandName,
    this.dosage,
    this.strength,
    required this.requiresPrescription,
    required this.isOverTheCounter,
    required this.sideEffects,
    required this.contraindications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      isSponsored: json['isSponsored'] as bool? ?? false,
      pharmacyId: json['pharmacyId'] as String,
      stock: json['stock'] as int,
      rating: (json['rating'] as num).toDouble(),
      benefits: List<String>.from(json['benefits'] ?? []),
      genericName: json['genericName'] as String?,
      brandName: json['brandName'] as String?,
      dosage: json['dosage'] as String?,
      strength: json['strength'] as String?,
      requiresPrescription: json['requiresPrescription'] as bool? ?? false,
      isOverTheCounter: json['isOverTheCounter'] as bool? ?? true,
      sideEffects: List<String>.from(json['sideEffects'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isSponsored': isSponsored,
      'pharmacyId': pharmacyId,
      'stock': stock,
      'rating': rating,
      'benefits': benefits,
      'genericName': genericName,
      'brandName': brandName,
      'dosage': dosage,
      'strength': strength,
      'requiresPrescription': requiresPrescription,
      'isOverTheCounter': isOverTheCounter,
      'sideEffects': sideEffects,
      'contraindications': contraindications,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    bool? isSponsored,
    String? pharmacyId,
    int? stock,
    double? rating,
    List<String>? benefits,
    String? genericName,
    String? brandName,
    String? dosage,
    String? strength,
    bool? requiresPrescription,
    bool? isOverTheCounter,
    List<String>? sideEffects,
    List<String>? contraindications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isSponsored: isSponsored ?? this.isSponsored,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      benefits: benefits ?? this.benefits,
      genericName: genericName ?? this.genericName,
      brandName: brandName ?? this.brandName,
      dosage: dosage ?? this.dosage,
      strength: strength ?? this.strength,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      isOverTheCounter: isOverTheCounter ?? this.isOverTheCounter,
      sideEffects: sideEffects ?? this.sideEffects,
      contraindications: contraindications ?? this.contraindications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }

  // Helper methods
  bool get isInStock => stock > 0;
  bool get isLowStock => stock > 0 && stock <= 5;
  bool get isOutOfStock => stock <= 0;
  bool get isHighlyRated => rating >= 4.0;
  bool get isWellRated => rating >= 3.5;
  bool get hasBenefits => benefits.isNotEmpty;
  bool get hasSideEffects => sideEffects.isNotEmpty;
  bool get hasContraindications => contraindications.isNotEmpty;

  String get displayName => brandName ?? name;
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get ratingText => '${rating.toStringAsFixed(1)} ★';
  String get stockStatus {
    if (isOutOfStock) return 'Out of Stock';
    if (isLowStock) return 'Low Stock';
    return 'In Stock';
  }

  String get stockColor {
    if (isOutOfStock) return '#F44336';
    if (isLowStock) return '#FF9800';
    return '#4CAF50';
  }
}
