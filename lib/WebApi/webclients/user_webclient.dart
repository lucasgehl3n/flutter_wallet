import 'dart:convert';
import 'package:carteira_app/WebApi/webclient.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/User.dart';
import 'package:http/http.dart';

class UserWebClient {
  Future<User> findUser(idUsuario) async {
    final String urlComplement = "users/" + idUsuario.toString();

    final Response response =
        await client.get(Uri.http(urlBase, urlComplement));

    final dynamic decodedJson = jsonDecode(response.body);
    return User.fromJson(decodedJson);
  }

  Future<bool> save(User user) async {
    final String urlComplement = "users/" + user.id.toString();
    Map<String, dynamic> params = {
      'user': GeneralInfos.getUserLoginId().toString(),
    };
    var update = user.id.isNotEmpty;
    var cartaoJson = user.toJson();
    var body = jsonEncode(cartaoJson);
    var headers = {
      "Content-type": "application/json",
    };

    if (update) {
      //Edição
      final Response response = await client.patch(
        Uri.http(urlBase, urlComplement, params),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return true;
      }
    } else {
      //Criação
      final Response response = await client.post(
        Uri.http(urlBase, urlComplement, params),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 201) {
        return true;
      }
    }

    return false;
  }
}
