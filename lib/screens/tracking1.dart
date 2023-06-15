import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firstpro/screens/camera.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:intl/intl.dart';

class TrackingScreen2 extends StatefulWidget {
  @override
  _TrackingScreen2State createState() => _TrackingScreen2State();
}

class _TrackingScreen2State extends State<TrackingScreen2> {
  late GoogleMapController _mapController;
  late bool _isTracking;
  late Position _startPosition;
  late Position? _lastPosition;
  double _distance = 0.0;
  Timer? _timer;
  int _elapsedSeconds = 0;
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _lastPosition = null;

    _getCurrentLocation();
    _isTracking = false;
  }

  void _getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        _lastPosition = position;
        _routePoints.add(
          LatLng(position.latitude, position.longitude),
        );
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _updateCameraPosition() {
    if (_lastPosition != null) {
      LatLng currentLatLng =
          LatLng(_lastPosition!.latitude, _lastPosition!.longitude);
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLatLng, zoom: 15.0),
        ),
      );
    }
  }

  void _startTracking() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    setState(() {
      _isTracking = true;
      _distance = 0.0;
      _elapsedSeconds = 0;
    });

    _startPosition = await Geolocator.getCurrentPosition();
    _lastPosition = _startPosition;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });

    Geolocator.getPositionStream().listen((Position currentPosition) {
      setState(() {
        double distanceInMeters = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          currentPosition.latitude,
          currentPosition.longitude,
        );

        _distance += distanceInMeters;
        _lastPosition = currentPosition;
        _routePoints
            .add(LatLng(_lastPosition!.latitude, _lastPosition!.longitude));
      });
    });
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId;
  }

  void _selesaiLari() async {
    String? userId = await getUserId();
    DateTime now = DateTime.now();
    BigInt timestamp = BigInt.from(now.millisecondsSinceEpoch);
    try {
      final url = Uri.parse('https://runpal.sirkell.com/api/history/create');
      final response = await http.post(
        url,
        body: {
          'user_id': userId.toString(),
          'distance': _distance.toString(),
          'time': _elapsedSeconds.toString(),
          'date': timestamp.toString(),
          'status': 'completed',
        },
      );
      print('Response Body: ${response.body}');
      print('Response Body: ${response.statusCode}');
      if (response.statusCode == 201) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraPage()),
        ); // Kembali ke halaman sebelumnya
      } else {
        throw Exception('Failed to send data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void _stopTracking() {
    _selesaiLari();
    _timer?.cancel();
    setState(() {
      _isTracking = false;
    });
  }

  String _formatDistance(double distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(2)} m';
    } else {
      double distanceInKm = distance / 1000;
      return '${distanceInKm.toStringAsFixed(2)} km';
    }
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursString = (hours < 10) ? '0$hours' : '$hours';
    String minutesString = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsString =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';

    return '$hoursString:$minutesString:$secondsString';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Screen'),
      ),
      body: _lastPosition != null
          ? Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _lastPosition!.latitude,
                      _lastPosition!.longitude,
                    ),
                    zoom: 15.0,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('route'),
                      color: Colors.blue,
                      width: 5,
                      points: _routePoints,
                    ),
                  },
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: _updateCameraPosition,
                    child: Icon(Icons.my_location),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _isTracking ? _stopTracking : _startTracking,
                        child: Text(
                            _isTracking ? 'Stop Tracking' : 'Start Tracking'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Distance: ${_formatDistance(_distance)}',
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      Text(
                        'Time: ${_formatTime(_elapsedSeconds)}',
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
