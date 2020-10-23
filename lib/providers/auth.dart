import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';

class Auth with ChangeNotifier {
  static String _apiKey = "AIzaSyCIfeMSm9wgbY-cwEL4WTs7MvWse7q70jA";
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String endpoint) async {
    final url = endpoint;
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final body = json.decode(response.body);
      if (body['error'] != null) {
        throw HttpException(body['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" +
            _apiKey;
    return _authenticate(email, password, url);
  }

  Future<void> login(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" +
            _apiKey;
    return _authenticate(email, password, url);
  }
}
