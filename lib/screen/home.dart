import 'package:firstpro/widget/kotak.dart';
import 'package:firstpro/widget/kotak2.dart';
import 'package:firstpro/widget/menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset('assets/icons/runpal.png', height: 50),
          actions: [
            Menu(),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi Kanzul',
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
                      judul: 'container 10',
                      text: 'container 10',
                      icon: Icons.history,
                    ),
                    Kotak(
                      judul: 'container 11',
                      text: 'container 11',
                      icon: Icons.history,
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
                          margin: const EdgeInsets.only(top: 16.0, right: 8.0),
                          padding: const EdgeInsets.only(right: 25, left: 25),
                          height: 300.0,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 46, 46, 46),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'USER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'LEVEL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 18.0),
                              Text(
                                '12',
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
                            margin:
                                const EdgeInsets.only(top: 16.0, right: 8.0),
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
                            margin:
                                const EdgeInsets.only(top: 16.0, right: 8.0),
                            height: 140.0,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 46, 46, 46),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'GOALS ACHIEVED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                Text(
                                  '15 Goals',
                                  style: TextStyle(
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
                      judul: 'Thursday, 13 May 2023',
                      text: '30 Min 5 Km',
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
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        // Logika ketika tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Go Run',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      )),
                ),
              ],
            )));
  }
}
