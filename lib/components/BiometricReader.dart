import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricReader extends StatefulWidget {
  const BiometricReader({Key? key}) : super(key: key);

  @override
  _BiometricReaderState createState() => _BiometricReaderState();
}

class _BiometricReaderState extends State<BiometricReader> {
  final LocalAuthentication auth = LocalAuthentication();
  bool authenticated = false;
  bool _isAuthenticating = false;
  Future _authenticate() async {
    authenticated = await auth.authenticate(
      localizedReason: ' ',
      // useErrorDialogs: true,
      stickyAuth: true,
    );

    setState(() {
      _isAuthenticating = false;
    });
    if (!mounted) return;
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

//flutterant - Biometric Authentication
  @override
  Widget build(BuildContext context) {
    _authenticate();
    return Center();
  }
}

class AuthApp {
  static Future<bool> authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();

    return await auth.authenticate(
      localizedReason: ' ',
      // useErrorDialogs: true,
      stickyAuth: true,
    );
  }
}
