import 'package:flutter/material.dart';

class User {
  String profilePicture;
  int age;
  String gender;
  double weight;
  double height;
  double bmi;
  String bloodType;
  List<String> allergies;
  List<String> chronicIllnesses;
  List<String> currentMedications;
  String phoneNumber;
  String email;
  String emergencyContact;
  String placeOfLiving;
  String lastDoctorVisit;
  String lastVaccination;
  String lastBloodTest;
  String lastLabTest;

  User({
    required this.profilePicture,
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
    required this.email,
    required this.emergencyContact,
    required this.placeOfLiving,
    required this.lastDoctorVisit,
    required this.lastVaccination,
    required this.lastBloodTest,
    required this.lastLabTest,
  });
}

class UserProfileProvider extends ChangeNotifier {
  User _user = User(
    profilePicture: 'assets/images/avatar.png',
    age: 30,
    gender: 'Male',
    weight: 70.0,
    height: 175.0,
    bmi: 22.9,
    bloodType: 'O+',
    allergies: ['Peanuts', 'Dust'],
    chronicIllnesses: ['Hypertension'],
    currentMedications: ['Aspirin'],
    phoneNumber: '123-456-7890',
    email: 'user@example.com',
    emergencyContact: '987-654-3210',
    placeOfLiving: 'New York, USA',
    lastDoctorVisit: '2025-05-01',
    lastVaccination: '2025-04-15',
    lastBloodTest: '2025-03-20',
    lastLabTest: '2025-02-10',
  );

  User get user => _user;

  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  String get userName => _user.profilePicture.split('/').last.split('.').first;
}
