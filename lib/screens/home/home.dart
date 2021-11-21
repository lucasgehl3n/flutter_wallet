import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/screens/home/boasVindas.dart';
import 'package:carteira_app/screens/home/meusCartoes.dart';
import 'package:flutter/material.dart';

class HomeCarteira extends StatefulWidget {
  HomeCarteira({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeCarteiraState createState() => _HomeCarteiraState();
}

class _HomeCarteiraState extends State<HomeCarteira> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        color: ColorsApplication.primaryColor,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.4),
        child: Column(
          children: [
            Row(
              children: [
                IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(flex: 8, child: BoasVindas()),
                    ],
                  ),
                ),
              ],
            ),
            MeusCartoes(),
          ],
        ),
      ),
    );
  }
}
