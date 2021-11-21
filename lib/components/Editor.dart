import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType? tipo;
  final bool? esconderConteudo;
  final int? tamanhoMaximo;
  final TextStyle? style;
  final TextAlign? alinhamento;
  final MaskTextInputFormatter? mascara;
  final int maxLines;
  Editor({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
    this.tipo,
    this.esconderConteudo,
    this.tamanhoMaximo,
    this.style,
    this.alinhamento,
    this.mascara,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: style ??
            TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
        maxLines: maxLines,
        decoration: InputDecoration(
          counterText: "",
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white, width: 2.0),
          // ),
        ),
        inputFormatters: _verificarMascara(), //Tipo de teclado
        keyboardType: tipo ?? TextInputType.text,
        obscureText: esconderConteudo ?? false,
        maxLength: tamanhoMaximo ?? TextField.noMaxLength,
        textAlign: alinhamento ?? TextAlign.start,
      ),
    );
  }

  List<MaskTextInputFormatter> _verificarMascara() {
    List<MaskTextInputFormatter> lista = [];
    if (mascara != null) {
      lista.add(mascara!);
    }
    return lista;
  }
}
