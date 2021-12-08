import 'dart:convert';
import 'package:carteira_app/WebApi/webclient.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/User.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

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

    var tipoRequest = update ? "PATCH" : "POST";
    var request = new MultipartRequest(
        tipoRequest, Uri.http(urlBase, urlComplement, params));

    _toModelUser(request, user);

    await _toRequestFile(user, request);

    var response = await request.send();
    if (update) {
      if (response.statusCode == 200) {
        return true;
      }
    } else {
      //Criação
      if (response.statusCode == 201) {
        return true;
      }
    }

    return false;
  }

  Future<void> _toRequestFile(User user, MultipartRequest request) async {
    if (user.profilePhoto != null) {
      var stream = new ByteStream(user.profilePhoto!.openRead());
      stream.cast();

      // get file length
      var length = await user.profilePhoto!.length();

      var multipartFile = new MultipartFile(
        'profilePhoto',
        stream,
        length,
        filename: basename(user.profilePhoto!.path),
      );

      request.files.add(multipartFile);
    }
  }

  void _toModelUser(MultipartRequest request, User user) {
    request.fields['id'] = user.id;
    request.fields['name'] = user.name;
    // if (user.profilePhoto != null) {
    //   request.fields['profilePhoto'] =
    //       base64Encode(File(user.profilePhoto!.path).readAsBytesSync();
    // }
  }
}
