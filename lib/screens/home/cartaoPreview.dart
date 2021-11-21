import 'package:carousel_slider/carousel_slider.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/Cartao.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CarouselCartaoPreview extends StatefulWidget {
  final List cardList;
  const CarouselCartaoPreview(this.cardList);

  @override
  _CarouselCartaoPreviewState createState() => _CarouselCartaoPreviewState();
}

class _CarouselCartaoPreviewState extends State<CarouselCartaoPreview> {
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

class CartaoPreview extends StatelessWidget {
  final Cartao cartao;
  CartaoPreview(this.cartao);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Color(0xff121212),
        borderRadius: BorderRadius.circular(8),
      ),

      // constraints:
      // BoxConstraints(minHeight: context).size.height * 0.25),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36, 24, 36, 24),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            IconeCartaoPreview(),
            NomeCartaoPreview(cartao),
            Spacer(),
            InfosCartaoPreview(cartao)
          ],
        ),
      ),
    );
  }
}

class InfosCartaoPreview extends StatelessWidget {
  final Cartao cartao;
  InfosCartaoPreview(this.cartao);

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
                cartao.numeroCartao,
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
                  cartao.retornarVencimentoFormatado(),
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

class IconeCartaoPreview extends StatelessWidget {
  const IconeCartaoPreview({
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

class NomeCartaoPreview extends StatelessWidget {
  final Cartao cartao;
  NomeCartaoPreview(this.cartao);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        cartao.descricao,
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
