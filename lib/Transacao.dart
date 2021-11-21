// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';

// final LocalAuthentication _localAuth = LocalAuthentication();

import 'package:flutter/material.dart';

class Transacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
    );
  }
}
// class Transacao extends StatefulWidget {
//   var _title = "Pronto";
//   var _message = "Toque no botão para iniciar a autenticação";
//   var _icone = Icons.settings_power;
//   var _colorIcon = Colors.yellow;
//   var _colorButton = Colors.blue;

//   @override
//   _TransacaoState createState() => _TransacaoState();
// }

// class _TransacaoState extends State<Transacao> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(''),
//       ),
//       body: Container(
//         color: Color(0xffFCFCFD),
//         constraints:
//             BoxConstraints(minHeight: MediaQuery.of(context).size.height),
//         child: Column(
//           children: [
//             IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(flex: 8, child: Text('as')),
//                   Expanded(flex: 4, child: Text('')),
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(flex: 5, child: Text('')),
//                 Expanded(flex: 7, child: Text('a')),
//                 GestureDetector(
//                   child: Icon(
//                     Icons.add,
//                     // color: Color(0xff394167),
//                     size: 30.0,
//                   ),
//                   onTap: () => _checkBiometricSensor(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _checkBiometricSensor() async {
//     var authenticate = await _localAuth.authenticateWithBiometrics(
//         localizedReason: 'Por favor autentique-se para continuar');
//     setState(() {
//       if (authenticate) {
//         widget._title = "Ótimo";
//         widget._message = "Verificação biométrica funcionou!!";
//         widget._icone = Icons.beenhere;
//         widget._colorIcon = Colors.green;
//         widget._colorButton = Colors.green;
//       } else {
//         widget._title = "Ops";
//         widget._message = "Tente novamente!";
//         widget._icone = Icons.clear;
//         widget._colorIcon = Colors.red;
//         widget._colorButton = Colors.red;
//       }
//     });
//   }
// }
