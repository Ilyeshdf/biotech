import 'package:flutter/foundation.dart';

@immutable
class LabResult {
  final String id;
  final String patientId;
  final String testName;
  final String result;
  final String unit;
  final String referenceRange;
  final DateTime testDate;
  final String status; // Normal, High, Low, Critical
  final String labName;
  final String doctorName;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String testCategory;
  final bool isUrgent;
  final String? specimenType;
  final String? collectionMethod;
  final DateTime? collectionDate;
  final String? collectionTime;

  const LabResult({
    required this.id,
    required this.patientId,
    required this.testName,
    required this.result,
    required this.unit,
    required this.referenceRange,
    required this.testDate,
    required this.status,
    required this.labName,
    required this.doctorName,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.testCategory,
    required this.isUrgent,
    this.specimenType,
    this.collectionMethod,
    this.collectionDate,
    this.collectionTime,
  });

  factory LabResult.fromJson(Map<String, dynamic> json) {
    return LabResult(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      testName: json['testName'] as String,
      result: json['result'] as String,
      unit: json['unit'] as String,
      referenceRange: json['referenceRange'] as String,
      testDate: DateTime.parse(json['testDate'] as String),
      status: json['status'] as String,
      labName: json['labName'] as String,
      doctorName: json['doctorName'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      testCategory: json['testCategory'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
      specimenType: json['specimenType'] as String?,
      collectionMethod: json['collectionMethod'] as String?,
      collectionDate: json['collectionDate'] != null
          ? DateTime.parse(json['collectionDate'] as String)
          : null,
      collectionTime: json['collectionTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'testName': testName,
      'result': result,
      'unit': unit,
      'referenceRange': referenceRange,
      'testDate': testDate.toIso8601String(),
      'status': status,
      'labName': labName,
      'doctorName': doctorName,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'testCategory': testCategory,
      'isUrgent': isUrgent,
      'specimenType': specimenType,
      'collectionMethod': collectionMethod,
      'collectionDate': collectionDate?.toIso8601String(),
      'collectionTime': collectionTime,
    };
  }

  LabResult copyWith({
    String? id,
    String? patientId,
    String? testName,
    String? result,
    String? unit,
    String? referenceRange,
    DateTime? testDate,
    String? status,
    String? labName,
    String? doctorName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? testCategory,
    bool? isUrgent,
    String? specimenType,
    String? collectionMethod,
    DateTime? collectionDate,
    String? collectionTime,
  }) {
    return LabResult(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      testName: testName ?? this.testName,
      result: result ?? this.result,
      unit: unit ?? this.unit,
      referenceRange: referenceRange ?? this.referenceRange,
      testDate: testDate ?? this.testDate,
      status: status ?? this.status,
      labName: labName ?? this.labName,
      doctorName: doctorName ?? this.doctorName,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      testCategory: testCategory ?? this.testCategory,
      isUrgent: isUrgent ?? this.isUrgent,
      specimenType: specimenType ?? this.specimenType,
      collectionMethod: collectionMethod ?? this.collectionMethod,
      collectionDate: collectionDate ?? this.collectionDate,
      collectionTime: collectionTime ?? this.collectionTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LabResult && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'LabResult(id: $id, testName: $testName, status: $status)';
  }

  // Helper methods
  bool get isNormal => status.toLowerCase() == 'normal';
  bool get isHigh => status.toLowerCase() == 'high';
  bool get isLow => status.toLowerCase() == 'low';
  bool get isCritical => status.toLowerCase() == 'critical';
  bool get isAbnormal => !isNormal;

  String get formattedTestDate {
    return '${testDate.day}/${testDate.month}/${testDate.year}';
  }

  String get formattedCollectionDate {
    if (collectionDate == null) return 'Not specified';
    return '${collectionDate!.day}/${collectionDate!.month}/${collectionDate!.year}';
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'normal':
        return '#4CAF50'; // Green
      case 'high':
        return '#FF9800'; // Orange
      case 'low':
        return '#2196F3'; // Blue
      case 'critical':
        return '#F44336'; // Red
      default:
        return '#9E9E9E'; // Grey
    }
  }

  String get statusIcon {
    switch (status.toLowerCase()) {
      case 'normal':
        return '✓';
      case 'high':
        return '↑';
      case 'low':
        return '↓';
      case 'critical':
        return '⚠';
      default:
        return '?';
    }
  }

  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(testDate).inDays;
    return difference <= 30; // Within last 30 days
  }

  bool get isOld {
    final now = DateTime.now();
    final difference = now.difference(testDate).inDays;
    return difference > 365; // Older than 1 year
  }

  String get ageDescription {
    final now = DateTime.now();
    final difference = now.difference(testDate).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    if (difference < 30) return '${(difference / 7).round()} weeks ago';
    if (difference < 365) return '${(difference / 30).round()} months ago';
    return '${(difference / 365).round()} years ago';
  }

  // Numeric result parsing (if applicable)
  double? get numericResult {
    try {
      return double.parse(result);
    } catch (e) {
      return null;
    }
  }

  // Check if result is within reference range
  bool get isWithinRange {
    if (numericResult == null) return true; // Non-numeric results

    try {
      final parts = referenceRange.split('-');
      if (parts.length == 2) {
        final min = double.parse(parts[0].trim());
        final max = double.parse(parts[1].trim());
        return numericResult! >= min && numericResult! <= max;
      }
    } catch (e) {
      // If parsing fails, assume it's within range
    }
    return true;
  }

  // Get trend direction (if multiple results exist)
  String get trendDirection {
    // This would need to be implemented with historical data
    return 'stable';
  }
}
