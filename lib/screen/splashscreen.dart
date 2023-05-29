import 'package:firstpro/screen/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _imageIndex = 0;
  List<String> _imagePaths = [
    'assets/icons/RUN.png',
    'assets/icons/PAL.png',
    'assets/icons/runpal.png',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (Timer timer) {
      if (_imageIndex < _imagePaths.length - 1) {
        setState(() {
          _imageIndex++;
        });
      } else {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Image.asset(
          _imagePaths[_imageIndex],
        ),
      ),
    );
  }
}
