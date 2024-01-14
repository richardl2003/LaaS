// status_user_page.dart
import 'package:flutter/material.dart';
import '../components/biometric_auth.dart';

class StatusUserPage extends StatefulWidget {
  @override
  _StatusUserPageState createState() => _StatusUserPageState();
}

class _StatusUserPageState extends State<StatusUserPage> {
  bool isUserAuthenticated = false;

  void onAuthenticationComplete(bool isAuthenticated) {
    setState(() {
      isUserAuthenticated = isAuthenticated;
    });

    if (isAuthenticated) {
      // Perform actions after successful authentication
      print('User is authenticated');
    } else {
      // Handle unsuccessful authentication
      print('User is not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status User Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Lockbox'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BiometricAuth(
                  onAuthenticationComplete: onAuthenticationComplete,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
