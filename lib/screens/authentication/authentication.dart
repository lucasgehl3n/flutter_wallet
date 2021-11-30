import 'package:carteira_app/components/BiometricReader.dart';
import 'package:carteira_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  Future<dynamic> authenticate(context) async {
    while (await AuthApp.authenticate() != true) {}

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeCarteira()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    authenticate(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        color: Color(0xff121212),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: SvgPicture.asset(
            'images/fingerprint.svg',
          ),
        ),
      ),
    );
  }
}
