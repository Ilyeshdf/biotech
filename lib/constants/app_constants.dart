const String defaultUserName = 'John Doe';
const String defaultUserSubtitle = 'Welcome back!';
const String defaultProfileImage = 'assets/images/profile.jpg';

// Add more constants as needed for dynamic values.

class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.yourbackend.com';

  // Asset Paths
  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/icons';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // Cache Keys
  static const String userCacheKey = 'user_data';
  static const String themeCacheKey = 'theme_mode';

  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String authError = 'Authentication failed. Please login again.';

  // Success Messages
  static const String profileUpdateSuccess = 'Profile updated successfully';
  static const String appointmentBookedSuccess =
      'Appointment booked successfully';

  // Validation Messages
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String passwordMismatch = 'Passwords do not match';
}
