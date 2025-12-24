# Medical App - Flutter Demo

A comprehensive Flutter medical application with modern UI design and complete app structure. This app demonstrates a full-featured medical platform with mock data for testing and development.

## 🚀 Features

### ✅ Completed Features
- **User Authentication** - Login/signup with mock data
- **Modern UI Design** - Beautiful, responsive interface with dark/light themes
- **Appointments Management** - View, create, and manage appointments
- **Prescriptions Tracking** - View prescription history and details
- **Lab Results** - View medical test results
- **Pharmacy Finder** - Find nearby pharmacies with details
- **Doctor Profiles** - Browse and view doctor information
- **Firebase Integration** - Ready for backend integration
- **State Management** - Provider pattern for app state
- **Error Handling** - Comprehensive error boundaries and handling
- **Mock Data Service** - Realistic test data for all features

### 🔄 In Progress
- Push notifications
- Real-time messaging
- Video consultations
- Payment integration

## 📱 App Structure

```
lib/
├── constants/          # App constants and configuration
├── models/            # Data models (User, Appointment, etc.)
├── providers/         # State management with Provider
├── screens/           # UI screens and pages
├── services/          # API and business logic
├── theme/             # App theming and styling
├── utils/             # Utility functions and helpers
├── widgets/           # Reusable UI components
└── main.dart          # App entry point
```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.2.3 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd me
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🔐 Test Credentials

For testing the app, use these credentials:

- **Email:** `test@example.com`
- **Password:** `password`

## 📊 Mock Data

The app includes comprehensive mock data for:

- **User Profile:** Complete medical profile with health information
- **Appointments:** 3 sample appointments (upcoming and past)
- **Prescriptions:** 2 active prescriptions with detailed medication info
- **Lab Results:** 2 recent lab test results
- **Pharmacies:** 3 nearby pharmacies with business hours
- **Doctors:** 3 specialist doctors with complete profiles

## 🎨 UI Features

- **Modern Design:** Clean, professional medical app interface
- **Dark/Light Themes:** Automatic theme switching
- **Responsive Layout:** Works on all screen sizes
- **Loading States:** Smooth loading animations
- **Error Handling:** User-friendly error messages
- **Accessibility:** Screen reader support

## 🔧 Configuration

### Firebase Setup
The app is configured with Firebase. To use your own Firebase project:

1. Create a Firebase project
2. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
3. Place them in the appropriate directories
4. Update Firebase configuration in `firebase_options.dart`

### API Configuration
Currently using mock data. To connect to a real backend:

1. Update `AppConstants.baseUrl` in `lib/constants/app_constants.dart`
2. Modify `ApiService` methods to make real API calls
3. Remove mock data service integration

## 📱 Screenshots

The app includes the following main screens:

- **Home Screen** - Dashboard with quick actions
- **Appointments** - View and manage appointments
- **Prescriptions** - Medication tracking
- **Lab Results** - Medical test results
- **Pharmacy** - Find nearby pharmacies
- **Find Doctor** - Browse doctors by specialty
- **Profile** - User profile and settings
- **Settings** - App configuration

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🔄 Next Steps

To complete the app integration:

1. **Backend API** - Connect to a real backend service
2. **Push Notifications** - Implement Firebase Cloud Messaging
3. **Real-time Features** - Add live chat and notifications
4. **Payment Integration** - Add subscription and payment features
5. **Testing** - Add unit and integration tests
6. **App Store Deployment** - Prepare for app store submission

## 🛡️ Security

- Secure storage for sensitive data
- Token-based authentication
- Input validation and sanitization
- Error boundary protection

## 📄 License

This project is for demonstration purposes. Feel free to use as a starting point for your medical app.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

If you need help with the app or have questions about the implementation, feel free to reach out!

---

**Note:** This is a demo app with mock data. For production use, replace mock services with real API integrations and add proper security measures.