import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/providers/ProviderFormularioCadastroCartao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class DatePickerVencimento extends StatefulWidget {
  final DateTime? dataInicial;
  DatePickerVencimento(this.dataInicial);
  @override
  DatePickerVencimentoState createState() => DatePickerVencimentoState();
}

class DatePickerVencimentoState extends State<DatePickerVencimento> {
  //Method for showing the date picker
  void _pickDateDialog(ProviderFormularioCadastroCartao providerForm) {
    showMonthPicker(
      context: context,
      initialDate: providerForm.dataValidadeSelecionada ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        providerForm.dataValidadeSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderFormularioCadastroCartao>(
      builder: (context, providerForm, child) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Vencimento',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Colors.white70,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        providerForm.dataValidadeSelecionada ==
                                null //ternary expression to check if date is null
                            ? ''
                            : DateFormat("MM/yy")
                                .format(providerForm.dataValidadeSelecionada!),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        label: Text('Selecionar'),
                        icon: Icon(Icons.calendar_today),
                        style: ElevatedButton.styleFrom(
                          primary: ColorsApplication.greenColor,
                          onPrimary: Colors.black87,
                        ),
                        onPressed: () {
                          return _pickDateDialog(providerForm);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
