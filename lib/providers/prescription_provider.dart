import 'package:flutter/foundation.dart';

class Prescription {
  final String medicationName;
  final String dosage;
  final String frequency;
  final String duration;
  final String startDate;
  final String endDate;
  final String doctorName;
  final String notes;
  final String status; // Active, Completed, Cancelled

  Prescription({
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.doctorName,
    required this.notes,
    required this.status,
  });
}

class PrescriptionProvider with ChangeNotifier {
  final List<Prescription> _prescriptions = [
    Prescription(
      medicationName: 'Amoxicillin',
      dosage: '500mg',
      frequency: '3 times daily',
      duration: '7 days',
      startDate: '2024-03-15',
      endDate: '2024-03-22',
      doctorName: 'Dr. Smith',
      notes: 'Take after meals',
      status: 'Active',
    ),
    Prescription(
      medicationName: 'Ibuprofen',
      dosage: '400mg',
      frequency: '2 times daily',
      duration: '5 days',
      startDate: '2024-03-10',
      endDate: '2024-03-15',
      doctorName: 'Dr. Johnson',
      notes: 'Take with food',
      status: 'Completed',
    ),
    Prescription(
      medicationName: 'Omeprazole',
      dosage: '20mg',
      frequency: 'Once daily',
      duration: '30 days',
      startDate: '2024-03-01',
      endDate: '2024-03-31',
      doctorName: 'Dr. Williams',
      notes: 'Take before breakfast',
      status: 'Active',
    ),
  ];

  List<Prescription> get prescriptions => [..._prescriptions];

  void addPrescription(Prescription prescription) {
    _prescriptions.add(prescription);
    notifyListeners();
  }

  void removePrescription(int index) {
    _prescriptions.removeAt(index);
    notifyListeners();
  }

  void updatePrescription(int index, Prescription newPrescription) {
    _prescriptions[index] = newPrescription;
    notifyListeners();
  }

  List<Prescription> getPrescriptionsByStatus(String status) {
    return _prescriptions.where((p) => p.status == status).toList();
  }

  List<Prescription> getActivePrescriptions() {
    return _prescriptions.where((p) => p.status == 'Active').toList();
  }

  List<Prescription> getCompletedPrescriptions() {
    return _prescriptions.where((p) => p.status == 'Completed').toList();
  }
}
