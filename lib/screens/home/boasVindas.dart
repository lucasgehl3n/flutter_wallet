import 'package:flutter/material.dart';

class BoasVindas extends StatelessWidget {
  const BoasVindas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36, 24, 36, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextosBoasVindas("Olá,"),
            TextosBoasVindas("Biribinhas"),
          ],
        ),
      ),
    );
  }
}

class TextosBoasVindas extends StatelessWidget {
  final String _textoExibicao;
  TextosBoasVindas(this._textoExibicao);
  @override
  Widget build(BuildContext context) {
    return Text(
      _textoExibicao,
      style: TextStyle(
        // fontFamily: 'Nunito',
        fontSize: 48,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: Colors.white,
      ),
    );
  }
}
