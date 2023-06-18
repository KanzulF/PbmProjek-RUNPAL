import 'package:firstpro/screens/displaypictures.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CameraPage extends StatefulWidget {
  final Uint8List routeImage;
  final String distance;
  final String time;

  const CameraPage(
      {super.key,
      required this.routeImage,
      required this.distance,
      required this.time});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras = [];
  late int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getAvailableCameras();
  }

  Future<void> _getAvailableCameras() async {
    _cameras = await availableCameras();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture; // Wait for the controller to be initialized
    if (mounted) {
      setState(() {}); // Trigger a rebuild after initialization
    }
  }

  void _flipCamera() {
    setState(() {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Future<void> _takePicture(
      Uint8List image, String distance, String time) async {
    try {
      await _initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      XFile picture = await _controller.takePicture();
      await picture.saveTo(path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            imagePath: path,
            routeImage: image,
            distance: distance,
            time: time,
          ),
        ),
      );
    } catch (e) {
      print("Camera error: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              const Text('Failed to capture the picture. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.asset('assets/icons/runpal.png', height: 50),
        actions: [
          IconButton(
            onPressed: _flipCamera,
            icon: Icon(Icons.flip_camera_ios),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _takePicture(widget.routeImage, widget.distance, widget.time),
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
