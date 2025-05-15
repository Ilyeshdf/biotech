import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorProfileScreen({Key? key, required this.doctorData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = doctorData['name'] ?? 'Unknown';
    final String specialty = doctorData['specialty'] ?? 'Unknown';
    final String profilePic =
        doctorData['profilePic'] ?? 'https://via.placeholder.com/150';
    final double rating = doctorData['rating'] ?? 0.0;
    final int reviews = doctorData['reviews'] ?? 0;
    final bool acceptingNewPatients =
        doctorData['acceptingNewPatients'] ?? false;
    final int experience = doctorData['experience'] ?? 0;
    final String about = doctorData['about'] ?? 'No information available.';
    final List<String> skills = List<String>.from(doctorData['skills'] ?? []);
    final List<String> achievements = List<String>.from(
      doctorData['achievements'] ?? [],
    );
    final String practiceLocation =
        doctorData['practiceLocation'] ?? 'Unknown location';
    final String phoneNumber = doctorData['phoneNumber'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Profile',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePic),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      specialty,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text(
                          '$rating',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      acceptingNewPatients
                          ? 'Accepting New Patients'
                          : 'Not Accepting New Patients',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: acceptingNewPatients ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Experience',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '$experience years',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Skills',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Wrap(
                      spacing: 8,
                      children:
                          skills
                              .map(
                                (skill) => Chip(
                                  label: Text(skill),
                                  backgroundColor: Colors.green.withOpacity(
                                    0.2,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Achievements',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          achievements
                              .map(
                                (achievement) => Text(
                                  '- $achievement',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'About',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      about,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Practice Location',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      practiceLocation,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200, // Placeholder height for the map
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Map Placeholder',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: $phoneNumber',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle booking logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Book Appointment',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
