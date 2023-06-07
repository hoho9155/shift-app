import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../types/partner.dart';
import '../types/register_partner.dart';
import '../types/user.dart';
import '../utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  Partner? _partner;
  User? _user;
  bool _isAuthenticated = false;
  bool isWorker = true;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  Partner? get partner => _partner;
  User? get user => _user;
  String? get token => _token;

  Future<bool> checkLogin(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final auth = prefs.getBool('auth');

    if (auth == null || auth == false) {
      return false;
    }

    _token = prefs.getString("token");
    return _token != null && _token != '';
  }

  Future<String> registerPartner(Partner partner) async {
    final Uri uri =
    Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_REGISTER}');
    try {
      final response = await http.post(uri, body: jsonEncode({
        'email': partner.email,
        'password': partner.password,
        'phoneNumber': partner.phoneNumber,
        'firstName': partner.firstName,
        'lastName': partner.lastName,
        'companyName': partner.companyName,
        'EIN': partner.EIN
      }), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        String token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
        await saveToken(token);

        _partner = Partner(id: data['id'],
            email: data['email'],
            phoneNumber: data['phoneNumber'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            companyName: data['companyName'],
            EIN: data['EIN']);
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }

  Future<String> registerWorker(User user) async {
    final Uri uri =
    Uri.parse('${AppConstants.API_URL}${AppConstants.WORKER_REGISTER}');
    try {
      final response = await http.post(uri, body: jsonEncode({
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'firstName': user.firstName,
        'lastName': user.lastName
      }), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        String token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
        await saveToken(token);

        _user = User(id: data['id'],
            email: data['email'],
            phoneNumber: data['phoneNumber'],
            firstName: data['firstName'],
            lastName: data['lastName']);
        return '';
      }
    }catch(_) {}

    return AppConstants.MSG_NETERROR;
  }

  Future<String> loginPartner(String email, String password) async {
    final Uri uri =
        Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_LOGIN}');
    try {
      final response = await http.post(uri, body: jsonEncode({
        'email': email,
        'password': password,
      }), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        String token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
        await saveToken(token);

        _partner = Partner(id: data['id'],
            email: data['email'],
            phoneNumber: data['phoneNumber'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            companyName: data['companyName'],
            EIN: data['EIN'],
            companyLocation: data['companyLocation'],
            birthyear: data['birthyear'],
            rating: data['rating'],
            address: data['address']);
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }

  Future<String> loginWorker(String phoneNumber) async {
    final Uri uri =
    Uri.parse('${AppConstants.API_URL}${AppConstants.WORKER_LOGIN}');
    try {
      final response = await http.post(uri, body: jsonEncode({
        'phoneNumber': phoneNumber
      }), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        String token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
        await saveToken(token);

        _user = User(id: data['id'],
            email: data['email'],
            phoneNumber: data['phoneNumber'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            headline: data['headline'],
            address: data['address'],
            birthyear: data['birthyear']);
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }

  saveToken(String tok) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', tok);
    _token = tok;
  }

  logout() async {
    final Uri uri =
    Uri.parse('${AppConstants.API_URL}${AppConstants.LOGOUT}');
    final response = await http.post(uri, body: {
      'id': isWorker ? _user!.id : _partner!.id
    }, headers: {
      'Accept': 'application/json',
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth', false);
    await saveToken('');
  }

  Future<String> profileCompany(Partner partner) async {
    final Uri uri =
    Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_COMPANYUPDATE}');
    try {
      final response = await http.post(uri, body: jsonEncode({
        'id': partner.id,
        'companyName': partner.companyName,
        'companyLocation': partner.companyLocation,
        'EIN': partner.EIN
      }), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }

  Future<String> profilePersonal(Map<String, dynamic> profile) async {
    final Uri uri =
    Uri.parse('${AppConstants.API_URL}${AppConstants.PERSONALUPDATE}');
    try {
      final response = await http.post(uri, body: jsonEncode({
        'id': profile['id'],
        'firstName': profile['firstName'],
        'lastName': profile['lastName'],
        'birthyear': profile['birthyear'],
        'address': profile['address']
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }
        return '';
      }
    }catch(_){}

    return AppConstants.MSG_NETERROR;
  }
}