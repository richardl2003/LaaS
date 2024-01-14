// biometric_auth.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth extends StatefulWidget {
  final Function(bool) onAuthenticationComplete;

  BiometricAuth({required this.onAuthenticationComplete});

  @override
  _BiometricAuthState createState() => _BiometricAuthState();
}

class _BiometricAuthState extends State<BiometricAuth> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: "Please authenticate to proceed",
      );
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    widget.onAuthenticationComplete(isAuthenticated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Authentication'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Authenticate'),
          onPressed: _authenticateUser,
        ),
      ),
    );
  }
}
