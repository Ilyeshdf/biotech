import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/modern_navbar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _currentIndex = 3; // Profile tab index

  void _onNavbarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProfileProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(user.profilePicture),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Age: ${user.age}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        Text(
                          'Gender: ${user.gender}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildInfoContainer('Physical Metrics', [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Weight: ${user.weight} kg',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    Text(
                      'Height: ${user.height} cm',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BMI: ${user.bmi}',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    Text(
                      'Blood Type: ${user.bloodType}',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
              ]),
              _buildInfoContainer('Medical Information', [
                Text(
                  'Allergies: ${user.allergies.join(", ")}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Chronic Illnesses: ${user.chronicIllnesses.join(", ")}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Current Medications: ${user.currentMedications.join(", ")}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ]),
              _buildInfoContainer('Contact Information', [
                Text(
                  'Phone: ${user.phoneNumber}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Email: ${user.email}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Emergency Contact: ${user.emergencyContact}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Place of Living: ${user.placeOfLiving}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ]),
              _buildInfoContainer('Recent Activity', [
                Text(
                  'Last Doctor Visit: ${user.lastDoctorVisit}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Last Vaccination: ${user.lastVaccination}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Last Blood Test: ${user.lastBloodTest}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Text(
                  'Last Lab Test: ${user.lastLabTest}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ]),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Update Profile Information',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ModernNavbar(
        currentIndex: _currentIndex,
        onTap: _onNavbarTap,
      ),
    );
  }

  Widget _buildInfoContainer(String title, List<Widget> children) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
