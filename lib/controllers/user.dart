import 'dart:convert';

import 'package:firstpro/models/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<User> getDataUser() async {
    final response =
        await http.get(Uri.parse('https://runpal.sirkell.com/api/user/all'));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('https://example.com/api/user/${user.id}'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }
}
