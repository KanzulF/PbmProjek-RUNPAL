import 'package:firstpro/screens/gorun.dart';
import 'package:firstpro/widgets/kotak.dart';
import 'package:firstpro/widgets/kotak2.dart';
import 'package:firstpro/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Home extends StatelessWidget {
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId;
  }

  Future<dynamic> getDataHistory() async {
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
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset('assets/icons/runpal.png', height: 50),
        actions: [
          Menu(),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([getDataUser(), getDataHistory()]),
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
            dynamic data = snapshot.data![0];
            dynamic data2 = snapshot.data![1];
            dynamic user = data['data']; // Ambil item pertama
            dynamic history = data2['data']; // Ambil item pertama
            return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi ${user['name']}',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const Text(
                      'Start a Run!',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Row(
                      children: [
                        Kotak(
                          judul: '2 Days',
                          text: 'From your last run',
                          icon: Icons.history,
                        ),
                        Kotak(
                          judul: '3 Km',
                          text: 'Run to increas your level',
                          icon: Icons.next_plan,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your Statistics',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(top: 16.0, right: 8.0),
                              padding:
                                  const EdgeInsets.only(right: 25, left: 25),
                              height: 300.0,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 46, 46, 46),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'USER',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'LEVEL',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 18.0),
                                  Text(
                                    '${user['level']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 18.0),
                                  Text(
                                    '3 Km more To Increase your level',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                    top: 16.0, right: 8.0),
                                height: 140.0,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 46, 46, 46),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DISTANCE TRAVELED',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                    Text(
                                      '40 Km',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 4, 255),
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6.0),
                                    Text(
                                      'in 25 days',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                    top: 16.0, right: 8.0),
                                height: 140.0,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 46, 46, 46),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'GOALS ACHIEVED',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      '${user['goals']} Goals',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 3, 255, 87),
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Records',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const Row(
                      children: [
                        Kotak2(
                          text1: 'Thursday, 13 May 2023',
                          text2: '30 Min 5 Km',
                        ),
                      ],
                    ),
                    // const Row(
                    //   children: [
                    //     Kotak2(
                    //       judul: 'Thursday, 13 May 2023',
                    //       text: '30 Min 5 Km',
                    //     ),
                    //   ],
                    // )
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GoRun(), // Ganti dengan layar tujuan untuk Menu 2
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Go Run',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )),
                    ),
                  ],
                ));
          }
        },
      ),
    );
  }
}
