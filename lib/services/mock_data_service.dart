import '../models/user.dart';
import '../models/appointment.dart';
import '../models/prescription.dart';
import '../models/lab_result.dart';
import '../models/pharmacy.dart';
import '../models/doctor.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // Mock user data
  User getMockUser() {
    return User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      profilePicture: 'https://i.pravatar.cc/300?img=1',
      age: 33,
      gender: 'Male',
      weight: 75.0,
      height: 175.0,
      bmi: 24.5,
      bloodType: 'O+',
      allergies: const ['Penicillin', 'Peanuts'],
      chronicIllnesses: const ['Hypertension'],
      currentMedications: const ['Lisinopril'],
      phoneNumber: '+1234567890',
      emergencyContact: 'Jane Doe',
      placeOfLiving: '123 Main St, City, State 12345',
      lastDoctorVisit: '2024-01-15',
      lastVaccination: '2023-12-01',
      lastBloodTest: '2024-01-10',
      lastLabTest: '2024-01-10',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      isProfileComplete: true,
    );
  }

  // Mock appointments data
  List<Appointment> getMockAppointments() {
    return [
      Appointment(
        id: '1',
        doctorId: 'doc1',
        doctorName: 'Dr. Sarah Johnson',
        specialty: 'Cardiology',
        patientId: '1',
        date: DateTime.now().add(const Duration(days: 2)),
        time: '10:00 AM',
        duration: 30,
        reason: 'Follow-up appointment for heart condition',
        status: 'Scheduled',
        notes: 'Follow-up appointment for heart condition',
        location: 'Medical Center - Cardiology Department',
        symptoms: const ['Chest pain', 'Shortness of breath'],
        isUrgent: false,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Appointment(
        id: '2',
        doctorId: 'doc2',
        doctorName: 'Dr. Michael Chen',
        specialty: 'Dermatology',
        patientId: '1',
        date: DateTime.now().add(const Duration(days: 7)),
        time: '2:30 PM',
        duration: 45,
        reason: 'Annual skin check',
        status: 'Scheduled',
        notes: 'Annual skin check',
        location: 'Dermatology Clinic',
        symptoms: const ['Skin rash'],
        isUrgent: false,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      Appointment(
        id: '3',
        doctorId: 'doc3',
        doctorName: 'Dr. Emily Rodriguez',
        specialty: 'General Medicine',
        patientId: '1',
        date: DateTime.now().subtract(const Duration(days: 3)),
        time: '9:00 AM',
        duration: 30,
        reason: 'Annual physical examination',
        status: 'Completed',
        notes: 'Annual physical examination completed',
        location: 'Primary Care Clinic',
        symptoms: const ['General check-up'],
        isUrgent: false,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  // Mock prescriptions data
  List<Prescription> getMockPrescriptions() {
    return [
      Prescription(
        id: '1',
        doctorId: 'doc1',
        doctorName: 'Dr. Sarah Johnson',
        specialty: 'Cardiology',
        patientId: '1',
        prescribedDate: DateTime.now().subtract(const Duration(days: 20)),
        expiryDate: DateTime.now().add(const Duration(days: 10)),
        diagnosis: 'Hypertension',
        medications: const [
          PrescriptionItem(
            id: 'med1',
            medicationName: 'Lisinopril',
            dosage: '10mg',
            frequency: 'Once daily',
            duration: '30 days',
            route: 'Oral',
            specialInstructions: 'Take in the morning with food',
            quantity: 30,
            genericName: 'Lisinopril',
            brandName: 'Zestril',
            sideEffects: ['Dizziness', 'Dry cough', 'Fatigue'],
            contraindications: ['Pregnancy', 'Angioedema history'],
          ),
        ],
        instructions:
            'Take in the morning with food. Monitor blood pressure regularly.',
        status: 'Active',
        notes: 'For blood pressure control',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 20)),
        isRefillable: true,
        refillCount: 0,
        maxRefills: 2,
      ),
      Prescription(
        id: '2',
        doctorId: 'doc3',
        doctorName: 'Dr. Emily Rodriguez',
        specialty: 'General Medicine',
        patientId: '1',
        prescribedDate: DateTime.now().subtract(const Duration(days: 30)),
        expiryDate: DateTime.now().add(const Duration(days: 60)),
        diagnosis: 'Hypercholesterolemia',
        medications: const [
          PrescriptionItem(
            id: 'med2',
            medicationName: 'Atorvastatin',
            dosage: '20mg',
            frequency: 'Once daily',
            duration: '90 days',
            route: 'Oral',
            specialInstructions: 'Take at bedtime',
            quantity: 90,
            genericName: 'Atorvastatin',
            brandName: 'Lipitor',
            sideEffects: ['Muscle pain', 'Nausea', 'Liver enzyme elevation'],
            contraindications: ['Liver disease', 'Pregnancy'],
          ),
        ],
        instructions: 'Take at bedtime. Avoid grapefruit juice.',
        status: 'Active',
        notes: 'For cholesterol management',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 30)),
        isRefillable: true,
        refillCount: 0,
        maxRefills: 1,
      ),
    ];
  }

  // Mock lab results data
  List<LabResult> getMockLabResults() {
    return [
      LabResult(
        id: '1',
        patientId: '1',
        testName: 'Hemoglobin',
        result: '14.2',
        unit: 'g/dL',
        referenceRange: '13.5-17.5',
        testDate: DateTime.now().subtract(const Duration(days: 5)),
        status: 'Normal',
        labName: 'Quest Diagnostics',
        doctorName: 'Dr. Emily Rodriguez',
        notes: 'All values within normal range',
        testCategory: 'Hematology',
        isUrgent: false,
        specimenType: 'Blood',
        collectionMethod: 'Venipuncture',
        collectionDate: DateTime.now().subtract(const Duration(days: 5)),
        collectionTime: '09:00',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      LabResult(
        id: '2',
        patientId: '1',
        testName: 'Total Cholesterol',
        result: '180',
        unit: 'mg/dL',
        referenceRange: '125-200',
        testDate: DateTime.now().subtract(const Duration(days: 10)),
        status: 'Normal',
        labName: 'LabCorp',
        doctorName: 'Dr. Sarah Johnson',
        notes: 'Cholesterol levels improved with medication',
        testCategory: 'Lipid Panel',
        isUrgent: false,
        specimenType: 'Blood',
        collectionMethod: 'Venipuncture',
        collectionDate: DateTime.now().subtract(const Duration(days: 10)),
        collectionTime: '08:30',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }

  // Mock pharmacies data
  List<Pharmacy> getMockPharmacies() {
    return [
      Pharmacy(
        id: '1',
        name: 'CVS Pharmacy',
        address: '123 Main St, City, State 12345',
        phone: '+1234567890',
        isOpen: true,
        rating: 4.5,
        imageUrl: 'https://i.pravatar.cc/300?img=10',
        services: const [
          'Prescription Filling',
          'Immunizations',
          'Health Screenings'
        ],
        website: 'https://www.cvs.com',
        email: 'pharmacy@cvs.com',
        description: '24/7 pharmacy with full services',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
        businessHours: const [
          BusinessHours(
              day: 'Monday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
          BusinessHours(
              day: 'Tuesday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
          BusinessHours(
              day: 'Wednesday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
          BusinessHours(
              day: 'Thursday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
          BusinessHours(
              day: 'Friday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
          BusinessHours(
              day: 'Saturday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
          BusinessHours(
              day: 'Sunday',
              openTime: '00:00',
              closeTime: '23:59',
              isClosed: false),
        ],
        acceptedInsurance: const ['Blue Cross Blue Shield', 'Aetna', 'Cigna'],
        hasDelivery: true,
        hasDriveThru: true,
        deliveryFee: 5.0,
        deliveryTime: 30,
        specialties: const ['General Pharmacy', 'Immunizations'],
        licenseNumber: 'PH123456',
        pharmacistName: 'Dr. John Smith',
        latitude: 40.7128,
        longitude: -74.0060,
      ),
      Pharmacy(
        id: '2',
        name: 'Walgreens',
        address: '456 Oak Ave, City, State 12345',
        phone: '+1234567891',
        isOpen: true,
        rating: 4.2,
        imageUrl: 'https://i.pravatar.cc/300?img=11',
        services: const [
          'Prescription Filling',
          'Photo Services',
          'Health Products'
        ],
        website: 'https://www.walgreens.com',
        email: 'pharmacy@walgreens.com',
        description: 'Full-service pharmacy with photo services',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
        businessHours: const [
          BusinessHours(
              day: 'Monday',
              openTime: '07:00',
              closeTime: '22:00',
              isClosed: false),
          BusinessHours(
              day: 'Tuesday',
              openTime: '07:00',
              closeTime: '22:00',
              isClosed: false),
          BusinessHours(
              day: 'Wednesday',
              openTime: '07:00',
              closeTime: '22:00',
              isClosed: false),
          BusinessHours(
              day: 'Thursday',
              openTime: '07:00',
              closeTime: '22:00',
              isClosed: false),
          BusinessHours(
              day: 'Friday',
              openTime: '07:00',
              closeTime: '22:00',
              isClosed: false),
          BusinessHours(
              day: 'Saturday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
          BusinessHours(
              day: 'Sunday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
        ],
        acceptedInsurance: const [
          'Blue Cross Blue Shield',
          'UnitedHealth',
          'Humana'
        ],
        hasDelivery: true,
        hasDriveThru: false,
        deliveryFee: 3.0,
        deliveryTime: 45,
        specialties: const ['General Pharmacy', 'Photo Services'],
        licenseNumber: 'PH789012',
        pharmacistName: 'Dr. Sarah Johnson',
        latitude: 40.7130,
        longitude: -74.0062,
      ),
      Pharmacy(
        id: '3',
        name: 'Rite Aid',
        address: '789 Pine St, City, State 12345',
        phone: '+1234567892',
        isOpen: false,
        rating: 4.0,
        imageUrl: 'https://i.pravatar.cc/300?img=12',
        services: const ['Prescription Filling', 'Health & Beauty'],
        website: 'https://www.riteaid.com',
        email: 'pharmacy@riteaid.com',
        description: 'Community pharmacy with health products',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
        businessHours: const [
          BusinessHours(
              day: 'Monday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
          BusinessHours(
              day: 'Tuesday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
          BusinessHours(
              day: 'Wednesday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
          BusinessHours(
              day: 'Thursday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
          BusinessHours(
              day: 'Friday',
              openTime: '08:00',
              closeTime: '21:00',
              isClosed: false),
          BusinessHours(
              day: 'Saturday',
              openTime: '09:00',
              closeTime: '20:00',
              isClosed: false),
          BusinessHours(
              day: 'Sunday',
              openTime: '09:00',
              closeTime: '20:00',
              isClosed: false),
        ],
        acceptedInsurance: const ['Blue Cross Blue Shield', 'Aetna'],
        hasDelivery: false,
        hasDriveThru: false,
        deliveryFee: null,
        deliveryTime: null,
        specialties: const ['General Pharmacy'],
        licenseNumber: 'PH345678',
        pharmacistName: 'Dr. Michael Chen',
        latitude: 40.7132,
        longitude: -74.0064,
      ),
    ];
  }

  // Mock doctors data
  List<Doctor> getMockDoctors() {
    return [
      Doctor(
        id: 'doc1',
        email: 'sarah.johnson@hospital.com',
        name: 'Dr. Sarah Johnson',
        profilePicture: 'https://i.pravatar.cc/300?img=5',
        specialty: 'Cardiology',
        licenseNumber: 'MD123456',
        medicalSchool: 'Harvard Medical School',
        graduationYear: 2008,
        experience: 15,
        practiceLocation: 'City General Hospital',
        phoneNumber: '+1234567890',
        about:
            'Board-certified cardiologist with 15 years of experience in treating heart conditions.',
        skills: const [
          'Echocardiography',
          'Cardiac Catheterization',
          'Stress Testing'
        ],
        achievements: const [
          'Board Certified Cardiologist',
          'Fellow of American College of Cardiology'
        ],
        certifications: const [
          'American Board of Internal Medicine',
          'Cardiovascular Disease'
        ],
        rating: 4.8,
        reviews: 127,
        acceptingNewPatients: true,
        languages: const ['English', 'Spanish'],
        consultationFee: '\$150',
        availableDays: const [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday'
        ],
        availableHours: const ['9:00 AM - 5:00 PM'],
        isVerified: true,
        role: 'doctor',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
      ),
      Doctor(
        id: 'doc2',
        email: 'michael.chen@hospital.com',
        name: 'Dr. Michael Chen',
        profilePicture: 'https://i.pravatar.cc/300?img=6',
        specialty: 'Dermatology',
        licenseNumber: 'MD789012',
        medicalSchool: 'Stanford Medical School',
        graduationYear: 2011,
        experience: 12,
        practiceLocation: 'University Medical Center',
        phoneNumber: '+1234567891',
        about:
            'Specialized in dermatological conditions and cosmetic procedures.',
        skills: const [
          'Skin Cancer Screening',
          'Cosmetic Dermatology',
          'Mohs Surgery'
        ],
        achievements: const [
          'Board Certified Dermatologist',
          'Fellow of American Academy of Dermatology'
        ],
        certifications: const ['American Board of Dermatology'],
        rating: 4.6,
        reviews: 89,
        acceptingNewPatients: true,
        languages: const ['English', 'Mandarin'],
        consultationFee: '\$120',
        availableDays: const ['Monday', 'Tuesday', 'Wednesday', 'Thursday'],
        availableHours: const ['8:00 AM - 6:00 PM'],
        isVerified: true,
        role: 'doctor',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
      ),
      Doctor(
        id: 'doc3',
        email: 'emily.rodriguez@hospital.com',
        name: 'Dr. Emily Rodriguez',
        profilePicture: 'https://i.pravatar.cc/300?img=7',
        specialty: 'General Medicine',
        licenseNumber: 'MD345678',
        medicalSchool: 'Johns Hopkins Medical School',
        graduationYear: 2015,
        experience: 8,
        practiceLocation: 'Community Health Center',
        phoneNumber: '+1234567892',
        about:
            'Primary care physician focused on preventive medicine and chronic disease management.',
        skills: const [
          'Preventive Care',
          'Chronic Disease Management',
          'Women\'s Health'
        ],
        achievements: const [
          'Board Certified Internal Medicine',
          'Patient Choice Award 2023'
        ],
        certifications: const ['American Board of Internal Medicine'],
        rating: 4.7,
        reviews: 156,
        acceptingNewPatients: true,
        languages: const ['English', 'Spanish'],
        consultationFee: '\$100',
        availableDays: const [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday'
        ],
        availableHours: const ['8:00 AM - 4:00 PM'],
        isVerified: true,
        role: 'doctor',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now(),
      ),
    ];
  }
}
