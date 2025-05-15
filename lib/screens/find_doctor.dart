import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_navbar.dart';
import 'buildSpecialityIcon.dart';
import 'doctor_profile_screen.dart';

class FindDoctor extends StatefulWidget {
  const FindDoctor({super.key});

  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  int _currentIndex = 0;

  void _onNavbarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildSpecialityIcon(
    String title,
    IconData icon,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DoctorListPage(specialty: title)),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 25, // Increased size for better visibility
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Icon(
              icon,
              size: 30,
              color: Colors.green,
            ), // Larger icon size
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 16), // Larger font size
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialty) {
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
                    'rating': 4.5,
                    'reviews': 120,
                    'acceptingNewPatients': true,
                    'experience': 10,
                    'about':
                        'Dr. $name is a highly experienced $specialty with over 10 years of experience.',
                    'skills': ['Skill 1', 'Skill 2', 'Skill 3'],
                    'achievements': ['Achievement 1', 'Achievement 2'],
                    'practiceLocation': '123 Medical Street, City',
                    'phoneNumber': '+1234567890',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Doctor',
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Specialities',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSpecialityIcon(
                          'Cardiac',
                          Icons.favorite,
                          context,
                        ),
                        _buildSpecialityIcon(
                          'Brain',
                          Icons.psychology,
                          context,
                        ),
                        _buildSpecialityIcon('Eyes', Icons.visibility, context),
                        _buildSpecialityIcon(
                          'Orthopedic',
                          Icons.accessibility,
                          context,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available Doctors',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: List.generate(
                        3,
                        (index) =>
                            _buildDoctorCard('Dr. John Doe', 'Cardiologist'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Rated Doctor',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildDoctorCard('Dr. John Doe', 'Cardiologist'),
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
}
