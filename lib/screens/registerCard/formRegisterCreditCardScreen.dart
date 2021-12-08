import 'dart:async';
import 'package:carteira_app/WebApi/webclients/creditCard_webclient.dart';
import 'package:carteira_app/components/InputEditor.dart';
import 'package:carteira_app/components/ResponseDialog.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/CreditCard.dart';
import 'package:carteira_app/providers/ProviderFormularioCadastroCartao.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'datePickerExpiration.dart';

class FormRegisterCreditCardScreen extends StatelessWidget {
  final CreditCard cartao;
  FormRegisterCreditCardScreen(this.cartao);

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
            create: (context) => ProviderFormRegisterCreditCard(),
            child: FieldsFormRegister(cartao),
          ),
        ),
      ),
    );
  }
}

class FieldsFormRegister extends StatefulWidget {
  final CreditCard creditCard;
  FieldsFormRegister(this.creditCard);
  @override
  _FieldsFormRegisterState createState() => _FieldsFormRegisterState();
}

class _FieldsFormRegisterState extends State<FieldsFormRegister> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();

  DateTime? dtaVencimentoExistente = new DateTime.now();
  final CreditCardWebClient _webClient = CreditCardWebClient();

  final maskFiledNumberCard =
      new MaskTextInputFormatter(mask: '####.####.####.####');

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = widget.creditCard.description;
    _numberController.text = widget.creditCard.number;
    _securityCodeController.text = widget.creditCard.securityCode;
    this.dtaVencimentoExistente = widget.creditCard.expirationDate;
    Provider.of<ProviderFormRegisterCreditCard>(context, listen: false)
        .expirationDateSelected = dtaVencimentoExistente;
    return Consumer<ProviderFormRegisterCreditCard>(
      builder: (context, providerForm, child) => Column(children: [
        InputEditor(
          controlador: _descriptionController,
          rotulo: 'Descrição',
          tipo: TextInputType.multiline,
          maxLines: 3,
        ),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: InputEditor(
                controlador: _numberController,
                rotulo: 'Número do cartão',
                tipo: TextInputType.number,
                mascara: maskFiledNumberCard,
              ),
            ),
            Expanded(
              flex: 4,
              child: InputEditor(
                controlador: _securityCodeController,
                rotulo: 'Cód. Segurança',
                tipo: TextInputType.number,
                mascara: maskFiledNumberCard,
              ),
            )
          ],
        ),
        DatePickerVencimento(dtaVencimentoExistente),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.creditCard.id.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: _deleteButton(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: _saveButton(providerForm),
            ),
          ],
        ),
      ]),
    );
  }

  ElevatedButton _saveButton(ProviderFormRegisterCreditCard providerForm) {
    return ElevatedButton.icon(
      onPressed: () {
        _saveCard(providerForm);
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
    );
  }

  ElevatedButton _deleteButton() {
    return ElevatedButton.icon(
      onPressed: () {
        _confirmDelete(context);
      },
      label: Text('Excluir'),
      icon: Icon(Icons.delete),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        primary: Colors.grey.shade200,
        onPrimary: Colors.black87,
      ),
    );
  }

  Future<String?> _confirmDelete(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Exclusão'),
        content: Text('Deseja confirmar a exclusão do cartão?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _delete();
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCard(ProviderFormRegisterCreditCard providerForm) async {
    var card = _toModel(providerForm);
    Future(() async {
      _validate(card);
      var salvar = await _sendSave(card, context);
      if (salvar) {
        Navigator.pop(context);
      }
    }).catchError((error) {
      _showError(error?.message ?? "");
    });
  }

  Future<dynamic> _showError(error) {
    return showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(error ?? "");
      },
    );
  }

  void _validate(CreditCard cartao) {
    if (cartao.description.isEmpty) {
      throw new Exception("Informe uma descrição!");
    }

    if (cartao.number.isEmpty) {
      throw new Exception("Informe o número do cartão!");
    }

    if (cartao.securityCode.isEmpty) {
      throw new Exception("Informe o código de segurança!");
    }

    if (cartao.expirationDate == null) {
      throw new Exception("Informe a data de vencimento!");
    }
  }

  Future<void> _delete() async {
    var delete = await _sendDelete(context);
    if (delete) {
      Navigator.pop(context);
    }
  }

  Future<bool> _sendSave(CreditCard cardModel, BuildContext context) async {
    return await _webClient.save(cardModel).catchError((error) {
      _showError(error);
    });
  }

  Future<bool> _sendDelete(BuildContext context) async {
    return await _webClient.delete(widget.creditCard.id).catchError((error) {
      _showError(error);
    });
  }

  CreditCard _toModel(ProviderFormRegisterCreditCard providerForm) {
    var dataVencimento = providerForm.expirationDateSelected;

    var cartao = widget.creditCard;
    cartao.expirationDate = dataVencimento;
    cartao.description = _descriptionController.text;
    cartao.number = _numberController.text;
    cartao.securityCode = _securityCodeController.text;

    return cartao;
  }
}
