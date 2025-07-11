import 'package:flutter/foundation.dart';

@immutable
class Appointment {
  final String id;
  final String doctorName;
  final String doctorId;
  final String specialty;
  final DateTime date;
  final String time;
  final String status; // Scheduled, Completed, Cancelled, Rescheduled
  final String notes;
  final String location;
  final String? patientId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int duration; // in minutes
  final String? reason;
  final List<String> symptoms;
  final bool isUrgent;

  const Appointment({
    required this.id,
    required this.doctorName,
    required this.doctorId,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.notes,
    required this.location,
    this.patientId,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
    this.reason,
    required this.symptoms,
    required this.isUrgent,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String,
      specialty: json['specialty'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String,
      location: json['location'] as String,
      patientId: json['patientId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      duration: json['duration'] as int? ?? 30,
      reason: json['reason'] as String?,
      symptoms: List<String>.from(json['symptoms'] ?? []),
      isUrgent: json['isUrgent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'doctorId': doctorId,
      'specialty': specialty,
      'date': date.toIso8601String(),
      'time': time,
      'status': status,
      'notes': notes,
      'location': location,
      'patientId': patientId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'duration': duration,
      'reason': reason,
      'symptoms': symptoms,
      'isUrgent': isUrgent,
    };
  }

  Appointment copyWith({
    String? id,
    String? doctorName,
    String? doctorId,
    String? specialty,
    DateTime? date,
    String? time,
    String? status,
    String? notes,
    String? location,
    String? patientId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? duration,
    String? reason,
    List<String>? symptoms,
    bool? isUrgent,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      doctorId: doctorId ?? this.doctorId,
      specialty: specialty ?? this.specialty,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      patientId: patientId ?? this.patientId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      duration: duration ?? this.duration,
      reason: reason ?? this.reason,
      symptoms: symptoms ?? this.symptoms,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Appointment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Appointment(id: $id, doctorName: $doctorName, date: $date, status: $status)';
  }

  // Helper methods
  bool get isUpcoming => date.isAfter(DateTime.now()) && status == 'Scheduled';
  bool get isPast => date.isBefore(DateTime.now());
  bool get isToday =>
      date.year == DateTime.now().year &&
      date.month == DateTime.now().month &&
      date.day == DateTime.now().day;

  bool get canBeCancelled => status == 'Scheduled' && isUpcoming;
  bool get canBeRescheduled => status == 'Scheduled' && isUpcoming;

  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDate = DateTime(date.year, date.month, date.day);

    if (appointmentDate == today) {
      return 'Today';
    } else if (appointmentDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (appointmentDate.isBefore(today)) {
      return '${date.day}/${date.month}/${date.year}';
    } else {
      final difference = appointmentDate.difference(today).inDays;
      return 'In $difference days';
    }
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return '#4CAF50'; // Green
      case 'completed':
        return '#2196F3'; // Blue
      case 'cancelled':
        return '#F44336'; // Red
      case 'rescheduled':
        return '#FF9800'; // Orange
      default:
        return '#9E9E9E'; // Grey
    }
  }

  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isCancelled => status.toLowerCase() == 'cancelled';
  bool get isScheduled => status.toLowerCase() == 'scheduled';
}
