import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/screens/authentication/authentication.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carteira APP',
      theme: ColorsApplication.themeMaterialApplication,
      home: Authentication(),
    );
  }
}
