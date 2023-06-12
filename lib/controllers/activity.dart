import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firstpro/models/activity.dart';

class ActivityRepository {
  Future<List<Activity>> getUserActivities() async {
    final response =
        await http.get(Uri.parse('https://example.com/api/user/activities'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Activity> activities = [];
      for (var item in jsonData) {
        activities.add(Activity.fromJson(item));
      }
      return activities;
    } else {
      throw Exception('Failed to load user activities');
    }
  }
}
