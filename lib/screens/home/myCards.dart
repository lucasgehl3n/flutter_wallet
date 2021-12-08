import 'package:carteira_app/WebApi/webclients/creditCard_webclient.dart';
import 'package:carteira_app/components/Loader.dart';
import 'package:carteira_app/components/NavigationTransition.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/CreditCard.dart';
import 'package:carteira_app/providers/ProviderCards.dart';
import 'package:carteira_app/screens/home/cartaoPreview.dart';
import 'package:carteira_app/screens/registerCard/formRegisterCreditCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCards extends StatelessWidget {
  MyCards();
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
      child: ChangeNotifierProvider(
        create: (context) => ProviderCards(),
        child: ListCreditCardSearch(),
      ),
    );
  }
}

class ListCreditCardSearch extends StatelessWidget {
  final CreditCardWebClient _webClient = CreditCardWebClient();

  ListCreditCardSearch();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCards>(
      builder: (context, providerForm, child) => Padding(
        padding: const EdgeInsets.all(48.0),
        // child: ListaCartoes(cardList: cardList),
        child: FutureBuilder<List<CreditCard>>(
          future: _webClient.findAll(),
          builder: (context, snapshot) {
            providerForm.cards = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Loader();

              //Tem um dado disponível, mas ainda não terminou (stream)
              //Ex: pedaço de um download falando progresso
              case ConnectionState.active:
                return Loader();
              case ConnectionState.done:
                return ListedCreditCards(
                  (providerForm.cards
                          ?.map(
                            (x) => CreditCardPreview(x),
                          )
                          .toList()) ??
                      [],
                );
            }
            return Loader();
          },
        ),
      ),
    );
  }
}

class ListedCreditCards extends StatefulWidget {
  final List<CreditCardPreview> cardList;
  const ListedCreditCards(this.cardList);

  @override
  State<ListedCreditCards> createState() => _ListedCreditCardsState();
}

class _ListedCreditCardsState extends State<ListedCreditCards> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.55),
        child: IntrinsicHeight(
          child: Container(
            child: _returnWidgets(context),
          ),
        ),
      ),
    );
  }

  Column _returnWidgets(BuildContext context) {
    List<Widget> listaWidgets = [];
    if (widget.cardList.isNotEmpty) {
      listaWidgets.add(CarouselCreditCardPreview(widget.cardList));
    } else {
      listaWidgets.add(
        Text('Nenhum registro encontrado'),
      );
    }
    listaWidgets.add(Spacer());
    listaWidgets.add(
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          onPressed: () => {
            _createCreditCard(
              context,
            )
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
    );
    return Column(children: listaWidgets);
  }

  void _createCreditCard(BuildContext context) {
    Navigator.of(context)
        .push(
      NavigationTransition.createRoute(
        FormRegisterCreditCardScreen(CreditCard.newCard()),
      ),
    )
        .then((value) async {
      final CreditCardWebClient _webClient = CreditCardWebClient();
      Provider.of<ProviderCards>(context, listen: false)
          .updateCards(await _webClient.findAll());
    });
  }
}
