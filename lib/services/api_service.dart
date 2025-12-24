import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../models/appointment.dart';
import '../models/prescription.dart';
import '../models/lab_result.dart';
import '../models/pharmacy.dart';
import '../utils/secure_storage.dart';
import 'mock_data_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  final SecureStorage _secureStorage = SecureStorage();
  final MockDataService _mockDataService = MockDataService();

  void initialize() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors for authentication and error handling
    _dio.interceptors.addAll([
      _AuthInterceptor(_secureStorage),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  // Authentication endpoints - Using mock data for development
  Future<ApiResponse<User>> signIn(String email, String password) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock authentication logic
      if (email == 'test@example.com' && password == 'password') {
        final user = _mockDataService.getMockUser();
        final token = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';

        await _secureStorage.saveToken(token);
        await _secureStorage.saveUser(user);

        return ApiResponse.success(user);
      } else {
        return ApiResponse.error('Invalid email or password');
      }
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }

  Future<ApiResponse<User>> signUp(
      String email, String password, String name) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Mock registration logic
      final user = _mockDataService.getMockUser().copyWith(
            email: email,
            name: name,
          );
      final token = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';

      await _secureStorage.saveToken(token);
      await _secureStorage.saveUser(user);

      return ApiResponse.success(user);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      // Continue with local cleanup even if server request fails
    } finally {
      await _secureStorage.clearAll();
    }
  }

  // User profile endpoints - Using mock data
  Future<ApiResponse<User>> getUserProfile() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final user = _mockDataService.getMockUser();
      return ApiResponse.success(user);
    } catch (e) {
      return ApiResponse.error('Failed to load user profile');
    }
  }

  Future<ApiResponse<User>> updateUserProfile(User user) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      await _secureStorage.saveUser(user);
      return ApiResponse.success(user);
    } catch (e) {
      return ApiResponse.error('Failed to update profile');
    }
  }

  // Appointments endpoints - Using mock data
  Future<ApiResponse<List<Appointment>>> getAppointments() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 700));

      final appointments = _mockDataService.getMockAppointments();
      return ApiResponse.success(appointments);
    } catch (e) {
      return ApiResponse.error('Failed to load appointments');
    }
  }

  Future<ApiResponse<Appointment>> createAppointment(
      Appointment appointment) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final createdAppointment = appointment.copyWith(
        id: 'app_${DateTime.now().millisecondsSinceEpoch}',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return ApiResponse.success(createdAppointment);
    } catch (e) {
      return ApiResponse.error('Failed to create appointment');
    }
  }

  Future<ApiResponse<Appointment>> updateAppointment(
      Appointment appointment) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      final updatedAppointment = appointment.copyWith(
        updatedAt: DateTime.now(),
      );
      return ApiResponse.success(updatedAppointment);
    } catch (e) {
      return ApiResponse.error('Failed to update appointment');
    }
  }

  Future<ApiResponse<void>> deleteAppointment(String id) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      return ApiResponse.success(null);
    } catch (e) {
      return ApiResponse.error('Failed to delete appointment');
    }
  }

  // Prescriptions endpoints - Using mock data
  Future<ApiResponse<List<Prescription>>> getPrescriptions() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 600));

      final prescriptions = _mockDataService.getMockPrescriptions();
      return ApiResponse.success(prescriptions);
    } catch (e) {
      return ApiResponse.error('Failed to load prescriptions');
    }
  }

  // Lab results endpoints - Using mock data
  Future<ApiResponse<List<LabResult>>> getLabResults() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final labResults = _mockDataService.getMockLabResults();
      return ApiResponse.success(labResults);
    } catch (e) {
      return ApiResponse.error('Failed to load lab results');
    }
  }

  // Pharmacy endpoints - Using mock data
  Future<ApiResponse<List<Pharmacy>>> getPharmacies() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 400));

      final pharmacies = _mockDataService.getMockPharmacies();
      return ApiResponse.success(pharmacies);
    } catch (e) {
      return ApiResponse.error('Failed to load pharmacies');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';

        switch (statusCode) {
          case 400:
            return 'Bad request: $message';
          case 401:
            return 'Authentication failed. Please login again.';
          case 403:
            return 'Access denied. You don\'t have permission to perform this action.';
          case 404:
            return 'Resource not found.';
          case 422:
            return 'Validation error: $message';
          case 500:
            return 'Server error. Please try again later.';
          default:
            return 'Error $statusCode: $message';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network settings.';
      case DioExceptionType.badCertificate:
        return 'Security certificate error.';
      case DioExceptionType.unknown:
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

// Interceptors
class _AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;

  _AuthInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _secureStorage.clearAll();
      // Navigate to login screen (handled by app)
    }
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    }
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Add custom error handling logic here
    handler.next(err);
  }
}
