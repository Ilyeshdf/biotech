import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'doctor_profile_screen.dart';

class DoctorListPage extends StatelessWidget {
  final String specialty;

  DoctorListPage({required this.specialty});

  @override
  Widget build(BuildContext context) {
    final doctors = getDoctorsBySpecialty(specialty);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors: $specialty',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Doctors',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return _buildDoctorCard(
                    context,
                    doctor['name']!,
                    doctor['specialty']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, String name, String specialty) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DoctorProfileScreen(
                  doctorData: {
                    'name': name,
                    'specialty': specialty,
                    'profilePic':
                        'https://via.placeholder.com/150', // Example profile picture
                    'rating': 4.7,
                    'reviews': 95,
                    'acceptingNewPatients': true,
                    'experience': 12,
                    'about':
                        'Dr. $name is a renowned $specialty with over 12 years of experience.',
                    'skills': ['Skill A', 'Skill B', 'Skill C'],
                    'achievements': ['Award 1', 'Award 2'],
                    'practiceLocation': '456 Health Avenue, City',
                    'phoneNumber': '+9876543210',
                  },
                ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/doctor.jpg'),
          ),
          title: Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(specialty, style: GoogleFonts.poppins(fontSize: 14)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
        ),
      ),
    );
  }

  List<Map<String, String>> getDoctorsBySpecialty(String specialty) {
    final allDoctors = [
      {'name': 'Dr. Ahmed', 'specialty': 'Cardiac'},
      {'name': 'Dr. Layla', 'specialty': 'Brain'},
      {'name': 'Dr. Noor', 'specialty': 'Eyes'},
      {'name': 'Dr. Sami', 'specialty': 'Orthopedic'},
    ];

    return allDoctors.where((doc) => doc['specialty'] == specialty).toList();
  }
}
