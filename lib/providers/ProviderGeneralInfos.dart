import 'package:carteira_app/models/User.dart';
import 'package:flutter/material.dart';

class ProviderGeneralInfos extends ChangeNotifier {
  User? userLogin;
  ProviderGeneralInfos(this.userLogin);

  updateUserLogin(User? user) {
    this.userLogin = user;
    notifyListeners();
  }
}
