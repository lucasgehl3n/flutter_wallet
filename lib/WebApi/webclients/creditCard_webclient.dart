import 'dart:convert';
import 'package:carteira_app/WebApi/webclient.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/CreditCard.dart';
import 'package:http/http.dart';

class CreditCardWebClient {
  Future<List<CreditCard>> findAll() async {
    final String urlTransactions = "payment-methods/";
    Map<String, dynamic> params = {
      'user': GeneralInfos.getUserLoginId().toString(),
    };

    final Response response =
        await client.get(Uri.http(urlBase, urlTransactions, params));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return _toCards(decodedJson);
  }

  List<CreditCard> _toCards(List<dynamic> json) {
    return json.map((dynamic json) => CreditCard.fromJson(json)).toList();
  }

  Future<bool> save(CreditCard cartao) async {
    var urlTransactions = "payment-methods/";
    Map<String, dynamic> params = {
      'user': GeneralInfos.getUserLoginId().toString(),
    };
    var update = cartao.id.isNotEmpty;
    var cartaoJson = cartao.toJson();
    var body = jsonEncode(cartaoJson);
    var headers = {
      "Content-type": "application/json",
    };

    if (update) {
      urlTransactions += cartao.id + "/";
      //Edição
      final Response response = await client.patch(
        Uri.http(urlBase, urlTransactions, params),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return true;
      }
    } else {
      //Criação
      final Response response = await client.post(
        Uri.http(urlBase, urlTransactions, params),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 201) {
        return true;
      }
    }

    return false;
  }

  Future<bool> delete(String id) async {
    var urlTransactions = "payment-methods/" + id + "/";
    Map<String, dynamic> params = {
      'user': GeneralInfos.getUserLoginId().toString(),
    };

    var headers = {
      "Content-type": "application/json",
    };

    //Edição
    final Response response = await client.delete(
      Uri.http(urlBase, urlTransactions, params),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
