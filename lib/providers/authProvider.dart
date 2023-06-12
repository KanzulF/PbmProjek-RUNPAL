import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<bool> login(String username, String password) async {
    // Panggil API untuk login dan verifikasi kredensial
    final response = await http
        .post(Uri.parse('https://runpal.sirkell.com/api/user/login'), body: {
      'username': username,
      'password': password,
    });

    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      // Jika login berhasil, simpan data pengguna ke dalam state
      _user = User.fromJson(jsonData);

      // Memberitahu listener bahwa state telah berubah
      notifyListeners();

      return true;
    } else {
      // Jika login gagal, hapus data pengguna dari state
      _user = null;

      // Memberitahu listener bahwa state telah berubah
      notifyListeners();

      return false;
    }
  }

  void logout() {
    // Hapus data pengguna dari state saat logout
    _user = null;

    // Memberitahu listener bahwa state telah berubah
    notifyListeners();
  }
}
