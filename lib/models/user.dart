import 'package:flutter/foundation.dart';

@immutable
class User {
  final String id;
  final String email;
  final String name;
  final String? profilePicture;
  final int age;
  final String gender;
  final double weight;
  final double height;
  final double bmi;
  final String bloodType;
  final List<String> allergies;
  final List<String> chronicIllnesses;
  final List<String> currentMedications;
  final String phoneNumber;
  final String emergencyContact;
  final String placeOfLiving;
  final String lastDoctorVisit;
  final String lastVaccination;
  final String lastBloodTest;
  final String lastLabTest;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isProfileComplete;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profilePicture,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.bloodType,
    required this.allergies,
    required this.chronicIllnesses,
    required this.currentMedications,
    required this.phoneNumber,
    required this.emergencyContact,
    required this.placeOfLiving,
    required this.lastDoctorVisit,
    required this.lastVaccination,
    required this.lastBloodTest,
    required this.lastLabTest,
    required this.createdAt,
    required this.updatedAt,
    required this.isProfileComplete,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profilePicture: json['profilePicture'] as String?,
      age: json['age'] as int,
      gender: json['gender'] as String,
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      bmi: (json['bmi'] as num).toDouble(),
      bloodType: json['bloodType'] as String,
      allergies: List<String>.from(json['allergies'] ?? []),
      chronicIllnesses: List<String>.from(json['chronicIllnesses'] ?? []),
      currentMedications: List<String>.from(json['currentMedications'] ?? []),
      phoneNumber: json['phoneNumber'] as String,
      emergencyContact: json['emergencyContact'] as String,
      placeOfLiving: json['placeOfLiving'] as String,
      lastDoctorVisit: json['lastDoctorVisit'] as String,
      lastVaccination: json['lastVaccination'] as String,
      lastBloodTest: json['lastBloodTest'] as String,
      lastLabTest: json['lastLabTest'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isProfileComplete: json['isProfileComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'bloodType': bloodType,
      'allergies': allergies,
      'chronicIllnesses': chronicIllnesses,
      'currentMedications': currentMedications,
      'phoneNumber': phoneNumber,
      'emergencyContact': emergencyContact,
      'placeOfLiving': placeOfLiving,
      'lastDoctorVisit': lastDoctorVisit,
      'lastVaccination': lastVaccination,
      'lastBloodTest': lastBloodTest,
      'lastLabTest': lastLabTest,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isProfileComplete': isProfileComplete,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profilePicture,
    int? age,
    String? gender,
    double? weight,
    double? height,
    double? bmi,
    String? bloodType,
    List<String>? allergies,
    List<String>? chronicIllnesses,
    List<String>? currentMedications,
    String? phoneNumber,
    String? emergencyContact,
    String? placeOfLiving,
    String? lastDoctorVisit,
    String? lastVaccination,
    String? lastBloodTest,
    String? lastLabTest,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isProfileComplete,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      chronicIllnesses: chronicIllnesses ?? this.chronicIllnesses,
      currentMedications: currentMedications ?? this.currentMedications,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      placeOfLiving: placeOfLiving ?? this.placeOfLiving,
      lastDoctorVisit: lastDoctorVisit ?? this.lastDoctorVisit,
      lastVaccination: lastVaccination ?? this.lastVaccination,
      lastBloodTest: lastBloodTest ?? this.lastBloodTest,
      lastLabTest: lastLabTest ?? this.lastLabTest,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ name.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name)';
  }

  // Validation methods
  bool get isValidAge => age > 0 && age < 150;
  bool get isValidWeight => weight > 0 && weight < 500;
  bool get isValidHeight => height > 0 && height < 300;
  bool get isValidBmi => bmi > 0 && bmi < 100;
  bool get isValidPhoneNumber => phoneNumber.length >= 10;
  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  // Helper methods
  String get displayName => name.isNotEmpty ? name : email;
  String get initials => name
      .split(' ')
      .map((e) => e.isNotEmpty ? e[0] : '')
      .join('')
      .toUpperCase();

  double calculateBmi() {
    if (height <= 0) return 0;
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBmiCategory() {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  bool get hasAllergies => allergies.isNotEmpty;
  bool get hasChronicIllnesses => chronicIllnesses.isNotEmpty;
  bool get hasCurrentMedications => currentMedications.isNotEmpty;
}
