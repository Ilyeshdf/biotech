import 'package:flutter/foundation.dart';

class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String status; // Scheduled, Completed, Cancelled
  final String notes;
  final String location;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.notes,
    required this.location,
  });
}

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [
    Appointment(
      id: '1',
      doctorName: 'Dr. Sarah Johnson',
      specialty: 'Cardiology',
      date: '2024-03-25',
      time: '10:00 AM',
      status: 'Scheduled',
      notes: 'Regular checkup',
      location: 'Main Hospital - Room 302',
    ),
    Appointment(
      id: '2',
      doctorName: 'Dr. Michael Chen',
      specialty: 'Dermatology',
      date: '2024-03-28',
      time: '2:30 PM',
      status: 'Scheduled',
      notes: 'Skin condition follow-up',
      location: 'Medical Center - Room 105',
    ),
    Appointment(
      id: '3',
      doctorName: 'Dr. Emily Brown',
      specialty: 'Pediatrics',
      date: '2024-03-20',
      time: '11:15 AM',
      status: 'Completed',
      notes: 'Annual checkup',
      location: 'Children\'s Hospital - Room 401',
    ),
  ];

  List<Appointment> get appointments => [..._appointments];

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void removeAppointment(String id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }

  void updateAppointment(Appointment updatedAppointment) {
    final index =
        _appointments.indexWhere((a) => a.id == updatedAppointment.id);
    if (index >= 0) {
      _appointments[index] = updatedAppointment;
      notifyListeners();
    }
  }

  List<Appointment> getAppointmentsByStatus(String status) {
    return _appointments.where((a) => a.status == status).toList();
  }

  List<Appointment> getUpcomingAppointments() {
    final now = DateTime.now();
    return _appointments.where((a) {
      final appointmentDate = DateTime.parse(a.date);
      return appointmentDate.isAfter(now) && a.status == 'Scheduled';
    }).toList();
  }
}
