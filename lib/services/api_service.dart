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

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  final SecureStorage _secureStorage = SecureStorage();

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

  // Authentication endpoints
  Future<ApiResponse<User>> signIn(String email, String password) async {
    try {
      final response = await _dio.post('/auth/signin', data: {
        'email': email,
        'password': password,
      });

      final user = User.fromJson(response.data['user']);
      final token = response.data['token'];

      await _secureStorage.saveToken(token);
      await _secureStorage.saveUser(user);

      return ApiResponse.success(user);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }

  Future<ApiResponse<User>> signUp(
      String email, String password, String name) async {
    try {
      final response = await _dio.post('/auth/signup', data: {
        'email': email,
        'password': password,
        'name': name,
      });

      final user = User.fromJson(response.data['user']);
      final token = response.data['token'];

      await _secureStorage.saveToken(token);
      await _secureStorage.saveUser(user);

      return ApiResponse.success(user);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      await _dio.post('/auth/signout');
    } catch (e) {
      // Continue with local cleanup even if server request fails
    } finally {
      await _secureStorage.clearAll();
    }
  }

  // User profile endpoints
  Future<ApiResponse<User>> getUserProfile() async {
    try {
      final response = await _dio.get('/user/profile');
      final user = User.fromJson(response.data);
      return ApiResponse.success(user);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to load user profile');
    }
  }

  Future<ApiResponse<User>> updateUserProfile(User user) async {
    try {
      final response = await _dio.put('/user/profile', data: user.toJson());
      final updatedUser = User.fromJson(response.data);
      await _secureStorage.saveUser(updatedUser);
      return ApiResponse.success(updatedUser);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to update profile');
    }
  }

  // Appointments endpoints
  Future<ApiResponse<List<Appointment>>> getAppointments() async {
    try {
      final response = await _dio.get('/appointments');
      final appointments = (response.data as List)
          .map((json) => Appointment.fromJson(json))
          .toList();
      return ApiResponse.success(appointments);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to load appointments');
    }
  }

  Future<ApiResponse<Appointment>> createAppointment(
      Appointment appointment) async {
    try {
      final response =
          await _dio.post('/appointments', data: appointment.toJson());
      final createdAppointment = Appointment.fromJson(response.data);
      return ApiResponse.success(createdAppointment);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to create appointment');
    }
  }

  Future<ApiResponse<Appointment>> updateAppointment(
      Appointment appointment) async {
    try {
      final response = await _dio.put('/appointments/${appointment.id}',
          data: appointment.toJson());
      final updatedAppointment = Appointment.fromJson(response.data);
      return ApiResponse.success(updatedAppointment);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to update appointment');
    }
  }

  Future<ApiResponse<void>> deleteAppointment(String id) async {
    try {
      await _dio.delete('/appointments/$id');
      return ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to delete appointment');
    }
  }

  // Prescriptions endpoints
  Future<ApiResponse<List<Prescription>>> getPrescriptions() async {
    try {
      final response = await _dio.get('/prescriptions');
      final prescriptions = (response.data as List)
          .map((json) => Prescription.fromJson(json))
          .toList();
      return ApiResponse.success(prescriptions);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to load prescriptions');
    }
  }

  // Lab results endpoints
  Future<ApiResponse<List<LabResult>>> getLabResults() async {
    try {
      final response = await _dio.get('/lab-results');
      final labResults = (response.data as List)
          .map((json) => LabResult.fromJson(json))
          .toList();
      return ApiResponse.success(labResults);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Failed to load lab results');
    }
  }

  // Pharmacy endpoints
  Future<ApiResponse<List<Pharmacy>>> getPharmacies() async {
    try {
      final response = await _dio.get('/pharmacies');
      final pharmacies = (response.data as List)
          .map((json) => Pharmacy.fromJson(json))
          .toList();
      return ApiResponse.success(pharmacies);
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
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
