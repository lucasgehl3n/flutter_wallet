import 'package:carteira_app/providers/ProviderGeneralInfos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeApplication extends StatefulWidget {
  WelcomeApplication();

  @override
  State<WelcomeApplication> createState() => _WelcomeApplicationState();
}

class _WelcomeApplicationState extends State<WelcomeApplication> {
  @override
  Widget build(BuildContext contexts) {
    return Consumer<ProviderGeneralInfos>(
      builder: (context, providerForm, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 24, 36, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextsWelcomeApplication("Olá,"),
                TextsWelcomeApplication(
                  providerForm.userLogin?.name ?? "",
                  textSize: 36,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextsWelcomeApplication extends StatelessWidget {
  final String _showedText;
  final double? textSize;
  TextsWelcomeApplication(this._showedText, {this.textSize = 48});
  @override
  Widget build(BuildContext context) {
    return Text(
      _showedText,
      style: TextStyle(
        // fontFamily: 'Nunito',
        fontSize: textSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: Colors.white,
      ),
    );
  }
}
