import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionExample extends StatefulWidget {
  const PermissionExample({super.key});

  @override
  State<PermissionExample> createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
  bool? isLimited;
  PermissionStatus? _permissionStatus;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    await dotenv.load();
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    PermissionStatus status;
    bool? isLimited;
    if (androidInfo.version.sdkInt > 32) {
      status = await Permission.photos.status;
      isLimited =  (dotenv.env['PERMISSION'] == "permission" ? await Permission.photos.isLimited : null);
      if (isLimited == null) throw Exception("TEST FAILED");
    } else {
      status = await Permission.storage.status;
      isLimited = await Permission.storage.isLimited;
    }
    setState(() {
      _permissionStatus = status;
      isLimited = isLimited;
    });
  }

  Future<void> _requestPermission() async {
    bool isLimited;
    PermissionStatus
        status; // Declared the status variable outside the try-catch block
    try {
      status = await Permission.photos.request();
      isLimited = await Permission.photos.isLimited;
    } catch (e) {
      status =
          PermissionStatus.denied; // Handled the exception in case of an error
      isLimited = false;
    }
    setState(() {
      _permissionStatus = status;
      isLimited = isLimited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Permission Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Photo Permission Status: ${_permissionStatus ?? "Unknown"}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Photo Permission IS LIMITED: ${isLimited ?? "Unknown"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermission,
              child: const Text('Request Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
