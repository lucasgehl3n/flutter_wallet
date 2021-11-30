import 'package:carteira_app/models/CreditCard.dart';
import 'package:flutter/material.dart';

class ProviderCards extends ChangeNotifier {
  List<CreditCard>? cards = [];
  ProviderCards({this.cards});

  updateCards(List<CreditCard>? cards) {
    this.cards = cards;
    notifyListeners();
  }
}
