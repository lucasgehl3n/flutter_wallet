import 'package:carousel_slider/carousel_slider.dart';
import 'package:carteira_app/WebApi/webclients/creditCard_webclient.dart';
import 'package:carteira_app/components/NavigationTransition.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/CreditCard.dart';
import 'package:carteira_app/providers/ProviderCards.dart';
import 'package:carteira_app/screens/registerCard/formRegisterCreditCardScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselCreditCardPreview extends StatefulWidget {
  final List<CreditCardPreview> cardList;
  CarouselCreditCardPreview(this.cardList);

  @override
  _CarouselCreditCardPreviewState createState() =>
      _CarouselCreditCardPreviewState();
}

class _CarouselCreditCardPreviewState extends State<CarouselCreditCardPreview> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: Duration(seconds: 6),
          ),
          items: widget.cardList.map((card) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: card,
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new DotsIndicator(
            dotsCount: widget.cardList.length,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              color: Colors.black87, // Inactive color
              activeColor: ColorsApplication.greenColor,
            ),
          ),
        )
      ],
    );
  }
}

class CreditCardPreview extends StatefulWidget {
  final CreditCard creditCard;
  CreditCardPreview(this.creditCard);

  @override
  State<CreditCardPreview> createState() => _CreditCardPreviewState();
}

class _CreditCardPreviewState extends State<CreditCardPreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: Color(0xff121212),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(36, 24, 36, 24),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              IconCreditCardPreview(),
              NameCreditCardPreview(widget.creditCard),
              Spacer(),
              InfosCartaoPreview(widget.creditCard)
            ],
          ),
        ),
      ),
      onTap: () {
        _editCreditCard(
          context,
          widget.creditCard,
        );
      },
    );
  }

  void _editCreditCard(BuildContext context, CreditCard creditCard) {
    Navigator.of(context)
        .push(
      NavigationTransition.createRoute(
        FormRegisterCreditCardScreen(creditCard),
      ),
    )
        .then((value) async {
      final CreditCardWebClient _webClient = new CreditCardWebClient();
      Provider.of<ProviderCards>(context, listen: false)
          .updateCards(await _webClient.findAll());
    });
  }
}

class InfosCartaoPreview extends StatelessWidget {
  final CreditCard creditCard;
  InfosCartaoPreview(this.creditCard);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                creditCard.number,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  creditCard.expirationDateFormat(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconCreditCardPreview extends StatelessWidget {
  const IconCreditCardPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Icon(
        Icons.credit_card,
        color: Colors.white,
      ),
    );
  }
}

class NameCreditCardPreview extends StatelessWidget {
  final CreditCard creditCard;
  NameCreditCardPreview(this.creditCard);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        creditCard.description,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
      ),
    );
  }
}
