import 'dart:io';
import 'package:carteira_app/WebApi/webclients/user_webclient.dart';
import 'package:carteira_app/components/InputEditor.dart';
import 'package:carteira_app/components/ResponseDialog.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormRegisterUserScreen extends StatelessWidget {
  final User user;

  FormRegisterUserScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      backgroundColor: ColorsApplication.primaryColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FieldsFormUserRegister(user),
        ),
      ),
    );
  }
}

class FieldsFormUserRegister extends StatefulWidget {
  final User user;

  FieldsFormUserRegister(this.user);
  @override
  _FieldsFormUserRegisterState createState() => _FieldsFormUserRegisterState();
}

class _FieldsFormUserRegisterState extends State<FieldsFormUserRegister> {
  final ImagePicker _picker = ImagePicker();
  File? _imageProfile;
  final TextEditingController _nameController = TextEditingController();
  final UserWebClient _webClient = UserWebClient();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              _selectImageGallery();
            },
            child: _userImage(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: InputEditor(
            controlador: _nameController,
            rotulo: 'Nome',
          ),
        ),
        Spacer(),
        _saveButton(),
      ],
    );
  }

  CircleAvatar _userImage() {
    return CircleAvatar(
      radius: 55,
      backgroundColor: ColorsApplication.greenColor,
      child: _imageProfile != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                File(_imageProfile!.path),
                width: 100,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            )
          : widget.user.urlProfilePhoto.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    widget.user.urlProfilePhoto,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.account_circle_sharp,
                    color: ColorsApplication.primaryColor,
                    size: 100,
                  ),
                ),
    );
  }

  _selectImageGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _imageProfile = File(image.path);
      }
    });
  }

  Future<void> _saveUser() async {
    var user = _toModel();
    Future(() async {
      _validate(user);
      var salvar = await _sendSave(user, context);
      if (salvar) {
        _imageProfile = null;
        final UserWebClient _webClient = UserWebClient();
        var userAtualizado =
            await _webClient.findUser(GeneralInfos.getUserLoginId());

        user.urlProfilePhoto = userAtualizado.urlProfilePhoto;
        Navigator.pop(context, user);
      }
    }).catchError((error) {
      _showError(error?.message ?? "");
    });
  }

  User _toModel() {
    var user = widget.user;
    user.name = _nameController.text;
    if (_imageProfile != null) {
      user.profilePhoto = _imageProfile;
    } else {
      user.profilePhoto = null;
    }
    return user;
  }

  void _validate(User user) {
    if (user.name.isEmpty) {
      throw new Exception("Informe um nome!");
    }
  }

  Future<dynamic> _showError(error) {
    return showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(error ?? "");
      },
    );
  }

  Future<bool> _sendSave(User userModel, BuildContext context) async {
    return await _webClient.save(userModel).catchError((error) {
      _showError(error);
    });
  }

  ElevatedButton _saveButton() {
    return ElevatedButton.icon(
      onPressed: () {
        _saveUser();
      },
      label: Text('Salvar'),
      icon: Icon(Icons.save),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        primary: ColorsApplication.greenColor,
        onPrimary: Colors.black87,
      ),
    );
  }
}
