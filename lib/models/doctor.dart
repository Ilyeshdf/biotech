import 'package:flutter/foundation.dart';

@immutable
class Doctor {
  final String id;
  final String email;
  final String name;
  final String? profilePicture;
  final String specialty;
  final String licenseNumber;
  final String medicalSchool;
  final int graduationYear;
  final int experience;
  final String practiceLocation;
  final String phoneNumber;
  final String about;
  final List<String> skills;
  final List<String> achievements;
  final List<String> certifications;
  final double rating;
  final int reviews;
  final bool acceptingNewPatients;
  final List<String> languages;
  final String consultationFee;
  final List<String> availableDays;
  final List<String> availableHours;
  final bool isVerified;
  final String role; // 'doctor'
  final DateTime createdAt;
  final DateTime updatedAt;

  const Doctor({
    required this.id,
    required this.email,
    required this.name,
    this.profilePicture,
    required this.specialty,
    required this.licenseNumber,
    required this.medicalSchool,
    required this.graduationYear,
    required this.experience,
    required this.practiceLocation,
    required this.phoneNumber,
    required this.about,
    required this.skills,
    required this.achievements,
    required this.certifications,
    required this.rating,
    required this.reviews,
    required this.acceptingNewPatients,
    required this.languages,
    required this.consultationFee,
    required this.availableDays,
    required this.availableHours,
    required this.isVerified,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profilePicture: json['profilePicture'] as String?,
      specialty: json['specialty'] as String,
      licenseNumber: json['licenseNumber'] as String,
      medicalSchool: json['medicalSchool'] as String,
      graduationYear: json['graduationYear'] as int,
      experience: json['experience'] as int,
      practiceLocation: json['practiceLocation'] as String,
      phoneNumber: json['phoneNumber'] as String,
      about: json['about'] as String,
      skills: List<String>.from(json['skills'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      acceptingNewPatients: json['acceptingNewPatients'] as bool,
      languages: List<String>.from(json['languages'] ?? []),
      consultationFee: json['consultationFee'] as String,
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableHours: List<String>.from(json['availableHours'] ?? []),
      isVerified: json['isVerified'] as bool? ?? false,
      role: json['role'] as String? ?? 'doctor',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'specialty': specialty,
      'licenseNumber': licenseNumber,
      'medicalSchool': medicalSchool,
      'graduationYear': graduationYear,
      'experience': experience,
      'practiceLocation': practiceLocation,
      'phoneNumber': phoneNumber,
      'about': about,
      'skills': skills,
      'achievements': achievements,
      'certifications': certifications,
      'rating': rating,
      'reviews': reviews,
      'acceptingNewPatients': acceptingNewPatients,
      'languages': languages,
      'consultationFee': consultationFee,
      'availableDays': availableDays,
      'availableHours': availableHours,
      'isVerified': isVerified,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Doctor copyWith({
    String? id,
    String? email,
    String? name,
    String? profilePicture,
    String? specialty,
    String? licenseNumber,
    String? medicalSchool,
    int? graduationYear,
    int? experience,
    String? practiceLocation,
    String? phoneNumber,
    String? about,
    List<String>? skills,
    List<String>? achievements,
    List<String>? certifications,
    double? rating,
    int? reviews,
    bool? acceptingNewPatients,
    List<String>? languages,
    String? consultationFee,
    List<String>? availableDays,
    List<String>? availableHours,
    bool? isVerified,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Doctor(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      specialty: specialty ?? this.specialty,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      medicalSchool: medicalSchool ?? this.medicalSchool,
      graduationYear: graduationYear ?? this.graduationYear,
      experience: experience ?? this.experience,
      practiceLocation: practiceLocation ?? this.practiceLocation,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      about: about ?? this.about,
      skills: skills ?? this.skills,
      achievements: achievements ?? this.achievements,
      certifications: certifications ?? this.certifications,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      acceptingNewPatients: acceptingNewPatients ?? this.acceptingNewPatients,
      languages: languages ?? this.languages,
      consultationFee: consultationFee ?? this.consultationFee,
      availableDays: availableDays ?? this.availableDays,
      availableHours: availableHours ?? this.availableHours,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Doctor && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, specialty: $specialty)';
  }

  // Validation methods
  bool get isValidLicenseNumber => licenseNumber.length >= 6;
  bool get isValidGraduationYear =>
      graduationYear >= 1950 && graduationYear <= DateTime.now().year;
  bool get isValidExperience => experience >= 0 && experience <= 50;
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

  bool get isExperienced => experience >= 5;
  bool get isHighlyRated => rating >= 4.5;
  bool get hasManyReviews => reviews >= 10;

  String get experienceText {
    if (experience == 0) return 'New';
    if (experience == 1) return '1 year';
    return '$experience years';
  }

  String get ratingText => '$rating ($reviews reviews)';
}
