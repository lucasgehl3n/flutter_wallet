// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';

// class AuthApp extends StatefulWidget {
//   @override
//   _AuthAppState createState() => _AuthAppState();
// }

// class _AuthAppState extends State<AuthApp> {
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   String _message = "Not Authorized";

//   Future<bool> checkingForBioMetrics() async {
//     bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
//     print(canCheckBiometrics);
//     return canCheckBiometrics;
//   }

//   Future<void> _authenticateMe() async {
// // 8. this method opens a dialog for fingerprint authentication.
// //    we do not need to create a dialog nut it popsup from device natively.
//     bool authenticated = false;
//     try {
//       authenticated = await _localAuthentication.authenticate(
//         localizedReason: "Authenticate for Testing", // message for dialog
//         biometricOnly: true,
//         useErrorDialogs: true, // show error in dialog
//         stickyAuth: true, // native process
//       );
//       setState(() {
//         _message = authenticated ? "Authorized" : "Not Authorized";
//       });
//     } catch (e) {
//       print(e);
//     }

//     if (!mounted) return;
//   }

//   @override
//   void initState() {
//     // checkingForBioMetrics();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Text("$_message"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _authenticateMe();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
