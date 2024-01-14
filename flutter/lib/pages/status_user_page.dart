// status_user_page.dart
import 'package:flutter/material.dart';
import '../components/biometric_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class StatusUserPage extends StatefulWidget {
  @override
  _StatusUserPageState createState() => _StatusUserPageState();
}

class _StatusUserPageState extends State<StatusUserPage> {
  final database = FirebaseDatabase.instance.ref();

  bool isUserAuthenticated = false;

  void onAuthenticationComplete(bool isAuthenticated) {
    setState(() {
      isUserAuthenticated = isAuthenticated;
    });

    if (isAuthenticated) {
      // Perform actions after successful authentication
      print('User is authenticated');
      openLockbox();
    } else {
      // Handle unsuccessful authentication
      print('User is not authenticated');
    }
  }

  void openLockbox () async {
    final boxRef = database.child('box/');
    try {
      await boxRef
        .update({
          'isOpen': 1
        }
      );
    } catch (e) {
      print(e);
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
