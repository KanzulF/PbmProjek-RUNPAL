import 'package:firstpro/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/widgets/kotak2.dart';
import 'package:firstpro/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId;
  }

  String _formatDistance(int distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';
    } else {
      double distanceInKm = distance / 1000;
      return '${distanceInKm.toStringAsFixed(2)} km';
    }
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursString =
        (hours > 0) ? '${hours.toString().padLeft(1, '0')} jam ' : '';
    String minutesString =
        (minutes > 0) ? '${minutes.toString().padLeft(1, '0')} menit ' : '';
    String secondsString =
        '${remainingSeconds.toString().padLeft(1, '0')} detik';

    return '$hoursString$minutesString$secondsString';
  }

  Future<dynamic> getDataUser() async {
    String? userId = await getUserId();
    final url = 'https://runpal.sirkell.com/api/history/getByUserId/$userId';

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
            print(data);
            dynamic history = data['data'];
            print("history");
            print(history);
            return SingleChildScrollView(
              padding:
                  EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
              child: Column(children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                for (int i = 0; i < history.length; i++)
                  Row(
                    children: [
                      Kotak2(
                        text1: '${history[i]['time']}',
                        text2:
                            '${_formatTime(history[i]['duration'])} ${_formatDistance(history[i]['distance'].toInt())} ',
                      ),
                    ],
                  ),
              ]),
            );
          }
        },
      ),
    );
  }
}
