import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/user_profile_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _placeOfLivingController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _chronicIllnessesController =
      TextEditingController();
  final TextEditingController _currentMedicationsController =
      TextEditingController();

  String? _gender;
  String? _bloodType;
  double _bmi = 0.0;

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_calculateBmi);
    _weightController.addListener(_calculateBmi);

    // Pre-fill existing user data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProfileProvider =
          Provider.of<UserProfileProvider>(context, listen: false);
      final currentUser = userProfileProvider.user;

      _ageController.text = currentUser.age.toString();
      _gender = currentUser.gender;
      _weightController.text = currentUser.weight.toString();
      _heightController.text = currentUser.height.toString();
      _bloodType = currentUser.bloodType;
      _phoneController.text = currentUser.phoneNumber;
      _emailController.text = currentUser.email;
      _emergencyContactController.text = currentUser.emergencyContact;
      _placeOfLivingController.text = currentUser.placeOfLiving;
      _allergiesController.text = currentUser.allergies.join(', ');
      _chronicIllnessesController.text =
          currentUser.chronicIllnesses.join(', ');
      _currentMedicationsController.text =
          currentUser.currentMedications.join(', ');

      // Calculate BMI from existing user data if available
      final double? initialWeight =
          double.tryParse(currentUser.weight.toString());
      final double? initialHeight =
          double.tryParse(currentUser.height.toString());
      if (initialWeight != null && initialHeight != null && initialHeight > 0) {
        final heightInMeters = initialHeight / 100;
        _bmi = initialWeight / (heightInMeters * heightInMeters);
      } else {
        _bmi = 0.0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _emergencyContactController.dispose();
    _placeOfLivingController.dispose();
    _allergiesController.dispose();
    _chronicIllnessesController.dispose();
    _currentMedicationsController.dispose();

    super.dispose();
  }

  void _calculateBmi() {
    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      setState(() {
        // BMI formula: weight (kg) / (height (m))^2
        // Assuming height is in cm, convert to meters
        final heightInMeters = height / 100;
        _bmi = weight / (heightInMeters * heightInMeters);
      });
    } else {
      setState(() {
        _bmi = 0.0;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final userProfileProvider =
          Provider.of<UserProfileProvider>(context, listen: false);
      final newUser = User(
        profilePicture:
            userProfileProvider.user.profilePicture, // Retain existing
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _gender ?? '',
        weight: double.tryParse(_weightController.text) ?? 0.0,
        height: double.tryParse(_heightController.text) ?? 0.0,
        bmi: _bmi,
        bloodType: _bloodType ?? '',
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        emergencyContact: _emergencyContactController.text,
        placeOfLiving: _placeOfLivingController.text,
        allergies: _allergiesController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        chronicIllnesses: _chronicIllnessesController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        currentMedications: _currentMedicationsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        lastDoctorVisit: userProfileProvider.user.lastDoctorVisit,
        lastVaccination: userProfileProvider.user.lastVaccination,
        lastBloodTest: userProfileProvider.user.lastBloodTest,
        lastLabTest: userProfileProvider.user.lastLabTest,
      );
      userProfileProvider.updateUser(newUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );

      // Go back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration',
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Personal Information'),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _ageController,
                labelText: 'Age',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              _buildDropdownField(
                value: _gender,
                items: ['Male', 'Female', 'Other'],
                labelText: 'Gender',
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your gender' : null,
              ),
              _buildSectionHeader('Physical Information'),
              _buildTextField(
                controller: _weightController,
                labelText: 'Weight (kg)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _heightController,
                labelText: 'Height (cm)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'BMI: ${_bmi.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              _buildDropdownField(
                value: _bloodType,
                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                labelText: 'Blood Type',
                onChanged: (value) {
                  setState(() {
                    _bloodType = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your blood type' : null,
              ),
              _buildSectionHeader('Contact Information'),
              _buildTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _emergencyContactController,
                labelText: 'Emergency Contact',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an emergency contact';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _placeOfLivingController,
                labelText: 'Place of Living',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your place of living';
                  }
                  return null;
                },
              ),
              _buildSectionHeader('Medical Information'),
              _buildTextField(
                controller: _allergiesController,
                labelText: 'Allergies (separate with commas)',
                validator: (value) => null,
              ),
              _buildTextField(
                controller: _chronicIllnessesController,
                labelText: 'Chronic Illnesses (separate with commas)',
                validator: (value) => null,
              ),
              _buildTextField(
                controller: _currentMedicationsController,
                labelText: 'Current Medications (separate with commas)',
                validator: (value) => null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 16),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String labelText,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: GoogleFonts.poppins(fontSize: 16)),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
      ),
    );
  }
}
