import 'package:firstpro/controllers/user.dart';
import 'package:firstpro/screens/map.dart';
import 'package:firstpro/screens/camera.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/widgets/kotak2.dart';
import 'package:firstpro/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoRun extends StatefulWidget {
  GoRun({Key? key}) : super(key: key);

  @override
  _GoRunState createState() => _GoRunState();
}

class _GoRunState extends State<GoRun> {
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId;
  }

  Future<dynamic> getDataUser() async {
    String? userId = await getUserId();
    final url = 'https://runpal.sirkell.com/api/user/get/$userId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return jsonData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.asset('assets/icons/runpal.png', height: 50),
        actions: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: const Icon(Icons.camera),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: getDataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            dynamic data = snapshot.data;
            dynamic user = data['data'];
            return Center(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                child: Column(children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Are You Ready?!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  MapScreen(),
                ]),
              ),
            );
          }
        },
      ),
    );
  }
}
