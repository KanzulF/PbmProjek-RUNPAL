import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final Uint8List routeImage;
  final String distance;
  final String time;

  const DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.routeImage,
    required this.distance,
    required this.time,
  }) : super(key: key);

  Future<void> _saveScreenshot(BuildContext context) async {
    print("klik ss");
    final ScreenshotController screenshotController = ScreenshotController();

    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      // Izin akses penyimpanan diberikan.
      // Lakukan tindakan yang diinginkan, misalnya menyimpan file.
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Izin akses penyimpanan ditolak atau ditolak secara permanen.
      // Tampilkan pesan atau lakukan tindakan yang sesuai.
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Permission Required'),
          content: Text('Please grant storage permission to continue.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                bool isGranted = await openAppSettings();
                if (isGranted) {
                  // Izin akses penyimpanan diberikan setelah diizinkan ulang.
                  // Lakukan tindakan yang diinginkan, misalnya menyimpan file.
                }
              },
              child: Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      );
    }

    final image = await screenshotController.capture();
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/Screenshots/screenshot.png';
    final file = File(imagePath);
    await file.writeAsBytes(image!);
    print('Screenshot saved: $imagePath');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Screenshot saved successfully.'),
      ),
    );
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
            onPressed: () => _saveScreenshot(context),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 16.0,
            bottom: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Waktu: ${time}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Jarak: ${distance}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Image.memory(
              routeImage,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
