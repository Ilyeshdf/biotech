import 'package:flutter/foundation.dart';

@immutable
class Prescription {
  final String id;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime prescribedDate;
  final DateTime? expiryDate;
  final String diagnosis;
  final List<PrescriptionItem> medications;
  final String instructions;
  final String status; // Active, Completed, Cancelled, Expired
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isRefillable;
  final int refillCount;
  final int maxRefills;

  const Prescription({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.prescribedDate,
    this.expiryDate,
    required this.diagnosis,
    required this.medications,
    required this.instructions,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.isRefillable,
    required this.refillCount,
    required this.maxRefills,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      prescribedDate: DateTime.parse(json['prescribedDate'] as String),
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      diagnosis: json['diagnosis'] as String,
      medications: (json['medications'] as List)
          .map((item) => PrescriptionItem.fromJson(item))
          .toList(),
      instructions: json['instructions'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isRefillable: json['isRefillable'] as bool? ?? false,
      refillCount: json['refillCount'] as int? ?? 0,
      maxRefills: json['maxRefills'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'specialty': specialty,
      'prescribedDate': prescribedDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'diagnosis': diagnosis,
      'medications': medications.map((item) => item.toJson()).toList(),
      'instructions': instructions,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isRefillable': isRefillable,
      'refillCount': refillCount,
      'maxRefills': maxRefills,
    };
  }

  Prescription copyWith({
    String? id,
    String? patientId,
    String? doctorId,
    String? doctorName,
    String? specialty,
    DateTime? prescribedDate,
    DateTime? expiryDate,
    String? diagnosis,
    List<PrescriptionItem>? medications,
    String? instructions,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isRefillable,
    int? refillCount,
    int? maxRefills,
  }) {
    return Prescription(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      prescribedDate: prescribedDate ?? this.prescribedDate,
      expiryDate: expiryDate ?? this.expiryDate,
      diagnosis: diagnosis ?? this.diagnosis,
      medications: medications ?? this.medications,
      instructions: instructions ?? this.instructions,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isRefillable: isRefillable ?? this.isRefillable,
      refillCount: refillCount ?? this.refillCount,
      maxRefills: maxRefills ?? this.maxRefills,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Prescription && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Prescription(id: $id, doctorName: $doctorName, status: $status)';
  }

  // Helper methods
  bool get isActive => status.toLowerCase() == 'active';
  bool get isExpired =>
      expiryDate != null && expiryDate!.isBefore(DateTime.now());
  bool get canBeRefilled =>
      isRefillable && refillCount < maxRefills && !isExpired;
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  String get formattedPrescribedDate {
    return '${prescribedDate.day}/${prescribedDate.month}/${prescribedDate.year}';
  }

  String get formattedExpiryDate {
    if (expiryDate == null) return 'No expiry date';
    return '${expiryDate!.day}/${expiryDate!.month}/${expiryDate!.year}';
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'active':
        return '#4CAF50'; // Green
      case 'completed':
        return '#2196F3'; // Blue
      case 'cancelled':
        return '#F44336'; // Red
      case 'expired':
        return '#FF9800'; // Orange
      default:
        return '#9E9E9E'; // Grey
    }
  }

  int get totalMedications => medications.length;
  bool get hasMultipleMedications => medications.length > 1;
}

@immutable
class PrescriptionItem {
  final String id;
  final String medicationName;
  final String dosage;
  final String frequency;
  final String duration;
  final String route; // Oral, Topical, Injectable, etc.
  final String? specialInstructions;
  final int quantity;
  final String? genericName;
  final String? brandName;
  final List<String> sideEffects;
  final List<String> contraindications;

  const PrescriptionItem({
    required this.id,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.route,
    this.specialInstructions,
    required this.quantity,
    this.genericName,
    this.brandName,
    required this.sideEffects,
    required this.contraindications,
  });

  factory PrescriptionItem.fromJson(Map<String, dynamic> json) {
    return PrescriptionItem(
      id: json['id'] as String,
      medicationName: json['medicationName'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
      route: json['route'] as String,
      specialInstructions: json['specialInstructions'] as String?,
      quantity: json['quantity'] as int,
      genericName: json['genericName'] as String?,
      brandName: json['brandName'] as String?,
      sideEffects: List<String>.from(json['sideEffects'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicationName': medicationName,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'route': route,
      'specialInstructions': specialInstructions,
      'quantity': quantity,
      'genericName': genericName,
      'brandName': brandName,
      'sideEffects': sideEffects,
      'contraindications': contraindications,
    };
  }

  PrescriptionItem copyWith({
    String? id,
    String? medicationName,
    String? dosage,
    String? frequency,
    String? duration,
    String? route,
    String? specialInstructions,
    int? quantity,
    String? genericName,
    String? brandName,
    List<String>? sideEffects,
    List<String>? contraindications,
  }) {
    return PrescriptionItem(
      id: id ?? this.id,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      route: route ?? this.route,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      quantity: quantity ?? this.quantity,
      genericName: genericName ?? this.genericName,
      brandName: brandName ?? this.brandName,
      sideEffects: sideEffects ?? this.sideEffects,
      contraindications: contraindications ?? this.contraindications,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PrescriptionItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PrescriptionItem(id: $id, medicationName: $medicationName, dosage: $dosage)';
  }

  // Helper methods
  String get displayName => brandName ?? medicationName;
  bool get hasSideEffects => sideEffects.isNotEmpty;
  bool get hasContraindications => contraindications.isNotEmpty;
  bool get hasSpecialInstructions =>
      specialInstructions != null && specialInstructions!.isNotEmpty;
}
