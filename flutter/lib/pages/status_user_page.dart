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
  bool isBoxOpen = false;

  void onAuthenticationComplete(bool isAuthenticated) {
    setState(() {
      isUserAuthenticated = isAuthenticated;
    });

    if (isBoxOpen) {
      closeLockbox();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StatusUserPage()));
    }
    else if (isUserAuthenticated) {
      // Perform actions after successful authentication
      print('User is authenticated');
      openLockbox();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StatusUserPage()));
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
      setState(() {
        isBoxOpen = true;
      });
    } catch (e) {
      print(e);
    }
  }

  void closeLockbox () async {
    final boxRef = database.child('box/');
    try {
      await boxRef
        .update({
          'isOpen': 0,
          'isFull': 0
        }
      );
      setState(() {
        isBoxOpen = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Order Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBoxOpen)
              ElevatedButton(
                child: Text('Close Lockbox'),
                onPressed: () {
                  closeLockbox();
                },
              ),
            if (!isBoxOpen)
              ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}