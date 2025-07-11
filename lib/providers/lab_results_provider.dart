import 'package:flutter/foundation.dart';

class LabResult {
  final String testName;
  final String result;
  final String unit;
  final String referenceRange;
  final String date;
  final String status; // Normal, High, Low
  final String labName;
  final String doctorName;
  final String notes;

  LabResult({
    required this.testName,
    required this.result,
    required this.unit,
    required this.referenceRange,
    required this.date,
    required this.status,
    required this.labName,
    required this.doctorName,
    required this.notes,
  });
}

class LabResultsProvider with ChangeNotifier {
  final List<LabResult> _labResults = [
    LabResult(
      testName: 'Complete Blood Count (CBC)',
      result: '5.2',
      unit: 'x10^9/L',
      referenceRange: '4.5-11.0',
      date: '2024-03-15',
      status: 'Normal',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'All parameters within normal range',
    ),
    LabResult(
      testName: 'Hemoglobin',
      result: '14.2',
      unit: 'g/dL',
      referenceRange: '13.5-17.5',
      date: '2024-03-15',
      status: 'Normal',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Normal hemoglobin levels',
    ),
    LabResult(
      testName: 'Glucose',
      result: '110',
      unit: 'mg/dL',
      referenceRange: '70-99',
      date: '2024-03-15',
      status: 'High',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Slightly elevated, follow up recommended',
    ),
    LabResult(
      testName: 'Cholesterol',
      result: '180',
      unit: 'mg/dL',
      referenceRange: '125-200',
      date: '2024-03-15',
      status: 'Normal',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Within healthy range',
    ),
    LabResult(
      testName: 'Vitamin D',
      result: '15',
      unit: 'ng/mL',
      referenceRange: '30-100',
      date: '2024-03-15',
      status: 'Low',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Vitamin D supplementation recommended',
    ),
    LabResult(
      testName: 'Iron',
      result: '45',
      unit: 'µg/dL',
      referenceRange: '50-170',
      date: '2024-03-15',
      status: 'Low',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Iron supplements may be needed',
    ),
    LabResult(
      testName: 'Blood Pressure',
      result: '140/90',
      unit: 'mmHg',
      referenceRange: '90/60-120/80',
      date: '2024-03-15',
      status: 'High',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Elevated blood pressure, lifestyle changes recommended',
    ),
    LabResult(
      testName: 'Thyroid Stimulating Hormone (TSH)',
      result: '4.8',
      unit: 'mIU/L',
      referenceRange: '0.4-4.0',
      date: '2024-03-15',
      status: 'High',
      labName: 'Central Medical Lab',
      doctorName: 'Dr. Smith',
      notes: 'Slightly elevated TSH, follow-up recommended',
    ),
  ];

  List<LabResult> get labResults => [..._labResults];

  void addLabResult(LabResult result) {
    _labResults.add(result);
    notifyListeners();
  }

  void removeLabResult(int index) {
    _labResults.removeAt(index);
    notifyListeners();
  }

  void updateLabResult(int index, LabResult newResult) {
    _labResults[index] = newResult;
    notifyListeners();
  }

  List<LabResult> getResultsByDate(String date) {
    return _labResults.where((result) => result.date == date).toList();
  }

  List<LabResult> getResultsByStatus(String status) {
    return _labResults.where((result) => result.status == status).toList();
  }

  List<LabResult> getResultsByLab(String labName) {
    return _labResults.where((result) => result.labName == labName).toList();
  }
}
