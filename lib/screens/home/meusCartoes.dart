import 'package:carteira_app/components/NavigationTransition.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/Cartao.dart';
import 'package:carteira_app/screens/cadastroCartao/formularioCadastroCartaoScreen.dart';
import 'package:carteira_app/screens/home/cartaoPreview.dart';
import 'package:flutter/material.dart';

class MeusCartoes extends StatelessWidget {
  final List<Widget> cardList = [
    CartaoPreview(new Cartao("C1", DateTime.now(), "256", ".... 4567")),
    CartaoPreview(new Cartao("C2", DateTime.now(), "246", ".... 4533")),
    CartaoPreview(new Cartao("C3", DateTime.now(), "333", ".... 4555")),
    CartaoPreview(new Cartao("C4", DateTime.now(), "222", ".... 4566")),
  ];
  MeusCartoes();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.6,
          minWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        color: Color(0xff232323),
      ),
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: ListaCartoes(cardList: cardList),
      ),
    );
  }
}

class ListaCartoes extends StatelessWidget {
  const ListaCartoes({
    Key? key,
    required this.cardList,
  }) : super(key: key);

  final List<Widget> cardList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.55),
        child: IntrinsicHeight(
          child: Container(
            child: Column(
              children: [
                CarouselCartaoPreview(cardList),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    // onPressed: () => {_exibirBottomSheet(context)},
                    onPressed: () => {
                      Navigator.of(context).push(
                        NavigationTransition.createRoute(
                          FormularioCadastroCartaoScreen(
                            new Cartao(
                                "C1",
                                DateTime.now().add(Duration(days: 60)),
                                "256",
                                ".... 4567"),
                          ),
                        ),
                      ),
                    },
                    child: Text('Adicionar Cartão'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26), // <-- Radius
                      ),
                      primary: ColorsApplication.greenColor,
                      onPrimary: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _exibirBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [FormularioCadastroCartao2()],
          ),
        );
      },
    );
  }
}

class FormularioCadastroCartao2 extends StatelessWidget {
  const FormularioCadastroCartao2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }
}
