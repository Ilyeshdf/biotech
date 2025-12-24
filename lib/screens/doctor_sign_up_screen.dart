import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';


class DoctorSignUpScreen extends StatefulWidget {
  const DoctorSignUpScreen({super.key});

  @override
  State<DoctorSignUpScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _medicalSchoolController = TextEditingController();
  final _graduationYearController = TextEditingController();
  final _experienceController = TextEditingController();
  final _practiceLocationController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _aboutController = TextEditingController();
  final _consultationFeeController = TextEditingController();

  String? _selectedSpecialty;
  List<String> _selectedSkills = [];
  List<String> _selectedLanguages = [];
  List<String> _selectedAvailableDays = [];
  List<String> _selectedAvailableHours = [];
  bool _acceptingNewPatients = true;

  final List<String> _specialties = [
    'Cardiology',
    'Dermatology',
    'Endocrinology',
    'Family Medicine',
    'Gastroenterology',
    'General Surgery',
    'Internal Medicine',
    'Neurology',
    'Obstetrics & Gynecology',
    'Oncology',
    'Ophthalmology',
    'Orthopedics',
    'Otolaryngology',
    'Pediatrics',
    'Psychiatry',
    'Pulmonology',
    'Radiology',
    'Urology',
  ];

  final List<String> _skills = [
    'Patient Care',
    'Diagnosis',
    'Treatment Planning',
    'Surgery',
    'Emergency Medicine',
    'Preventive Care',
    'Chronic Disease Management',
    'Pediatric Care',
    'Geriatric Care',
    'Mental Health',
    'Women\'s Health',
    'Men\'s Health',
    'Sports Medicine',
    'Nutrition',
    'Alternative Medicine',
  ];

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Arabic',
    'Chinese',
    'Hindi',
    'Japanese',
    'Korean',
    'Portuguese',
    'Russian',
    'Italian',
  ];

  final List<String> _availableDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> _availableHours = [
    'Morning (8 AM - 12 PM)',
    'Afternoon (12 PM - 4 PM)',
    'Evening (4 PM - 8 PM)',
    'Night (8 PM - 12 AM)',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _licenseNumberController.dispose();
    _medicalSchoolController.dispose();
    _graduationYearController.dispose();
    _experienceController.dispose();
    _practiceLocationController.dispose();
    _phoneNumberController.dispose();
    _aboutController.dispose();
    _consultationFeeController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final apiService = ApiService();
      // Use standard signUp for now, or create doctorSpecificSignUp in ApiService later
      final response = await apiService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
      );

      if (mounted) Navigator.pop(context);

      if (response.error == null) {
        // Create doctor profile logic would go here
        // For now, navigate to home (skipping verification)
        if (mounted) Navigator.pushReplacementNamed(context, '/home');
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.error ?? 'Error during registration')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Registration',
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Account Information'),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Personal Information'),
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  value: _selectedSpecialty,
                  items: _specialties,
                  labelText: 'Specialty',
                  onChanged: (value) {
                    setState(() {
                      _selectedSpecialty = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your specialty' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _licenseNumberController,
                  labelText: 'Medical License Number',
                  hintText: 'Enter your license number',
                  prefixIcon: Icons.badge_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your license number';
                    }
                    if (value.length < 6) {
                      return 'License number must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Education & Experience'),
                _buildTextField(
                  controller: _medicalSchoolController,
                  labelText: 'Medical School',
                  hintText: 'Enter your medical school',
                  prefixIcon: Icons.school_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your medical school';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _graduationYearController,
                  labelText: 'Graduation Year',
                  hintText: 'Enter graduation year',
                  prefixIcon: Icons.calendar_today_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter graduation year';
                    }
                    final year = int.tryParse(value);
                    if (year == null ||
                        year < 1950 ||
                        year > DateTime.now().year) {
                      return 'Please enter a valid year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _experienceController,
                  labelText: 'Years of Experience',
                  hintText: 'Enter years of experience',
                  prefixIcon: Icons.work_outline,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter years of experience';
                    }
                    final experience = int.tryParse(value);
                    if (experience == null ||
                        experience < 0 ||
                        experience > 50) {
                      return 'Please enter a valid number of years';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Practice Information'),
                _buildTextField(
                  controller: _practiceLocationController,
                  labelText: 'Practice Location',
                  hintText: 'Enter your practice location',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your practice location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneNumberController,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _consultationFeeController,
                  labelText: 'Consultation Fee',
                  hintText: 'Enter consultation fee (e.g., \$100)',
                  prefixIcon: Icons.attach_money_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter consultation fee';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _aboutController,
                  labelText: 'About',
                  hintText: 'Tell patients about yourself and your practice',
                  prefixIcon: Icons.description_outlined,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter information about yourself';
                    }
                    if (value.length < 50) {
                      return 'Please provide more detailed information (at least 50 characters)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Skills & Languages'),
                _buildMultiSelectField(
                  title: 'Skills',
                  items: _skills,
                  selectedItems: _selectedSkills,
                  onChanged: (items) {
                    setState(() {
                      _selectedSkills = items;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildMultiSelectField(
                  title: 'Languages Spoken',
                  items: _languages,
                  selectedItems: _selectedLanguages,
                  onChanged: (items) {
                    setState(() {
                      _selectedLanguages = items;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Availability'),
                _buildMultiSelectField(
                  title: 'Available Days',
                  items: _availableDays,
                  selectedItems: _selectedAvailableDays,
                  onChanged: (items) {
                    setState(() {
                      _selectedAvailableDays = items;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildMultiSelectField(
                  title: 'Available Hours',
                  items: _availableHours,
                  selectedItems: _selectedAvailableHours,
                  onChanged: (items) {
                    setState(() {
                      _selectedAvailableHours = items;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildSwitchField(
                  title: 'Accepting New Patients',
                  value: _acceptingNewPatients,
                  onChanged: (value) {
                    setState(() {
                      _acceptingNewPatients = value;
                    });
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Register as Doctor',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
    String? hintText,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String labelText,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildMultiSelectField({
    required String title,
    required List<String> items,
    required List<String> selectedItems,
    required void Function(List<String>) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (selected) {
                final newSelection = List<String>.from(selectedItems);
                if (selected) {
                  newSelection.add(item);
                } else {
                  newSelection.remove(item);
                }
                onChanged(newSelection);
              },
              selectedColor: Colors.green.withOpacity(0.2),
              checkmarkColor: Colors.green,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSwitchField({
    required String title,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.green,
        ),
      ],
    );
  }
}
