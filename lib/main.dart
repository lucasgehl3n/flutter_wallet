import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ColorsApplication.themeMaterialApplication,
      home: HomeCarteira(title: 'Flutter Demo Home Page'),
    );
  }
}
