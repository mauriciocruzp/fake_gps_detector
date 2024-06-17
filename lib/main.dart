import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  Future<void> _checkVersion() async {
    // final response = await http.get(Uri.parse('https://your-backend-url.com/version'));
    // if (response.statusCode == 200) {
    //   final minVersion = jsonDecode(response.body)['minimum_version'];
      final minVersion = '2.0.0';
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (_isUpdateRequired(currentVersion, minVersion)) {
        _showUpdateDialog();
      }
    // } else {
    //   throw Exception('Failed to load version info');
    // }
  }

  bool _isUpdateRequired(String currentVersion, String minVersion) {
    final currentParts = currentVersion.split('.').map(int.parse).toList();
    final minParts = minVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < minParts.length; i++) {
      if (currentParts[i] < minParts[i]) {
        return true;
      } else if (currentParts[i] > minParts[i]) {
        return false;
      }
    }
    return false;
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Update Required'),
        content: Text('A new version of the app is available. Please update to continue.'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Update'),
            onPressed: () {
              // Replace with your app's store URL
              const appStoreUrl = 'https://play.google.com/store/apps/details?id=com.supercell.clashofclans';
              launch(appStoreUrl);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the app!'),
      ),
    );
  }
}
