import 'package:flutter/material.dart';
import '../models/user.dart' as Model;
import '../services/api_service.dart';

class UserProfileProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Model.User? _user;
  bool _isLoading = false;
  String? _error;

  Model.User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> start() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getUserProfile();
      if (response.error == null) {
        _user = response.data;
      } else {
        _error = response.error;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> save(Model.User user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _apiService.updateUserProfile(user);
      if (response.error == null) {
        _user = response.data;
      } else {
        _error = response.error;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateUser(Model.User newUser) {
      _user = newUser;
      notifyListeners();
  }
}
