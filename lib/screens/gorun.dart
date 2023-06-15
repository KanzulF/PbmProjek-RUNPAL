import 'package:firstpro/controllers/user.dart';
import 'package:firstpro/screens/map.dart';
import 'package:firstpro/screens/tracking1.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/widgets/kotak2.dart';
import 'package:firstpro/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

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
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingScreen2(),
                    ),
                  );
                },
                label: const Text(
                  'Ready',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                icon: Icon(
                  Icons.directions_run,
                  size: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.green,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: MapScreen(),
            );
          }
        },
      ),
    );
  }
}
