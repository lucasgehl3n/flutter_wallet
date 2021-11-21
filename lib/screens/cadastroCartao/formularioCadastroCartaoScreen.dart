import 'package:carteira_app/components/Editor.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/Cartao.dart';
import 'package:carteira_app/providers/ProviderFormularioCadastroCartao.dart';
import 'package:carteira_app/screens/cadastroCartao/datePickerVencimento.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class FormularioCadastroCartaoScreen extends StatelessWidget {
  final Cartao cartao;
  FormularioCadastroCartaoScreen(this.cartao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      backgroundColor: ColorsApplication.primaryColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ChangeNotifierProvider(
            create: (context) => ProviderFormularioCadastroCartao(),
            child: CamposFormularioCadastro(cartao),
          ),
        ),
      ),
    );
  }
}

class CamposFormularioCadastro extends StatefulWidget {
  final Cartao cartao;
  CamposFormularioCadastro(this.cartao);
  @override
  _CamposFormularioCadastroState createState() =>
      _CamposFormularioCadastroState();
}

class _CamposFormularioCadastroState extends State<CamposFormularioCadastro> {
  final TextEditingController _apelidoController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _codigoSegurancaController =
      TextEditingController();

  DateTime? dtaVencimentoExistente = new DateTime.now();

  final maskCampoNumeroCartao =
      new MaskTextInputFormatter(mask: '####.####.####.####');

  @override
  Widget build(BuildContext context) {
    _apelidoController.text = widget.cartao.descricao;
    _numeroController.text = widget.cartao.numeroCartao;
    _codigoSegurancaController.text = widget.cartao.codSeguranca;
    this.dtaVencimentoExistente = widget.cartao.vencimento;
    Provider.of<ProviderFormularioCadastroCartao>(context)
        .dataValidadeSelecionada = dtaVencimentoExistente;
    return Consumer<ProviderFormularioCadastroCartao>(
      builder: (context, providerForm, child) => Column(children: [
        Editor(
          controlador: _apelidoController,
          rotulo: 'Descrição',
          tipo: TextInputType.multiline,
          maxLines: 3,
        ),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Editor(
                controlador: _numeroController,
                rotulo: 'Número do cartão',
                tipo: TextInputType.number,
                mascara: maskCampoNumeroCartao,
              ),
            ),
            Expanded(
              flex: 4,
              child: Editor(
                controlador: _codigoSegurancaController,
                rotulo: 'Cód. Segurança',
                tipo: TextInputType.number,
                mascara: maskCampoNumeroCartao,
              ),
            )
          ],
        ),
        DatePickerVencimento(dtaVencimentoExistente),
        Spacer(),
        ElevatedButton.icon(
          onPressed: () {
            _salvarRegistro(providerForm);
          },
          label: Text('Salvar'),
          icon: Icon(Icons.save),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            primary: ColorsApplication.greenColor,
            onPrimary: Colors.black87,
          ),
        ),
      ]),
    );
  }

  void _salvarRegistro(ProviderFormularioCadastroCartao providerForm) {
    var cartao = _montarModel(providerForm);
    Navigator.of(context).pop();
  }

  Cartao _montarModel(ProviderFormularioCadastroCartao providerForm) {
    var dataVencimento = providerForm.dataValidadeSelecionada;

    var cartao = widget.cartao;
    cartao.vencimento = dataVencimento;
    cartao.descricao = _apelidoController.text;
    cartao.numeroCartao = _numeroController.text;
    cartao.codSeguranca = _codigoSegurancaController.text;

    return cartao;
  }
}
