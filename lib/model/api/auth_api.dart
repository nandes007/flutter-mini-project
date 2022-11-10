import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_app/config/api.dart';
import 'package:laundry_app/widgets/notification_text.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AuthAPI with ChangeNotifier {
  Status _status = Status.uninitialized;
  String? _token;
  NotificationText? _notification;

  Status get status => _status;
  String? get token => _token;
  NotificationText? get notification => _notification;

  /// Initialized
  initAuthProvider() async {
    String? token = await getToken();
    if (token != null) {
      _token = token;
      _status = Status.authenticated;
    } else {
      _status = Status.unauthenticated;
    }
    notifyListeners();
  }

  /// Register user
  Future<Map> register({
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };

    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.'
    };

    final response = await http.post(
      Uri.parse('${Api.users}/register'),
      headers: <String, String>{
        'Accept': 'application/json;',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      _notification = const NotificationText(
        text: 'Registration successful, please log in.',
        type: 'info',
      );
      notifyListeners();
      result['success'] = true;
      return result;
    }

    Map apiResponse = json.decode(response.body);

    if (response.statusCode == 422) {
      if (apiResponse['errors'].containsKey('email')) {
        result['message'] = apiResponse['errors']['email'][0];
        return result;
      }

      if (apiResponse['errors'].containsKey('password')) {
        result['message'] = apiResponse['errors']['password'][0];
        return result;
      }

      return result;
    }

    return result;
  }

  /// Login user
  Future<bool> login(String email, String password) async {
    _status = Status.uninitialized;
    _notification = null;
    notifyListeners();

    Map<String, String> body = {
      'email': email,
      'password': password,
      'device_name': 'Sony'
    };

    final response = await http.post(
      Uri.parse('${Api.users}/login'),
      body: body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      _status = Status.authenticated;
      _token = apiResponse['token'];
      await storeUserData(apiResponse);
      _status = Status.authenticated;
      notifyListeners();
      return true;
    }

    if (response.statusCode == 401) {
      _notification = const NotificationText(
        text: 'Invalid email or password.',
        type: 'type',
      );
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }

    _status = Status.unauthenticated;
    _notification = const NotificationText(
      text: 'Server Error',
      type: 'type',
    );
    return false;
  }

  /// Store data data to storage
  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['token']);
    notifyListeners();
    return token;
  }

  /// Getting token
  Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    notifyListeners();
    return token;
  }

  /// Logout user - clear token in storage
  logOut([bool tokenExpired = false]) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    if (tokenExpired == true) {
      _notification = const NotificationText(
        text: 'Session expired. Please log in again.',
        type: 'info',
      );
    }

    String? token = storage.getString('token');

    final response = await http.post(
      Uri.parse('${Api.users}/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      storage.remove('token');
      _status = Status.unauthenticated;
      notifyListeners();
    }
  }
}
