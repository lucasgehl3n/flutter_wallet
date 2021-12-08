import 'package:carteira_app/WebApi/webclients/user_webclient.dart';
import 'package:carteira_app/components/Loader.dart';
import 'package:carteira_app/components/NavigationTransition.dart';
import 'package:carteira_app/general/general.dart';
import 'package:carteira_app/models/User.dart';
import 'package:carteira_app/providers/ProviderGeneralInfos.dart';
import 'package:carteira_app/screens/home/meusCartoes.dart';
import 'package:carteira_app/screens/home/welcome.dart';
import 'package:carteira_app/screens/registerUser/formRegisterUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCarteira extends StatefulWidget {
  HomeCarteira({Key? key}) : super(key: key);

  @override
  _HomeCarteiraState createState() => _HomeCarteiraState();
}

class _HomeCarteiraState extends State<HomeCarteira> {
  final UserWebClient _webClient = UserWebClient();
  User? user;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _webClient.findUser(GeneralInfos.getUserLoginId()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          user = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Scaffold(body: Loader());

            //Tem um dado disponível, mas ainda não terminou (stream)
            //Ex: pedaço de um download falando progresso
            case ConnectionState.active:
              return Scaffold(body: Loader());

            case ConnectionState.done:
              return appHome(user, context);
          }
        }

        return Scaffold(body: Loader());
      },
    );
  }

  MultiProvider appHome(User? user, BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderGeneralInfos>(
          create: (_) => ProviderGeneralInfos(user),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: ColorsApplication.primaryColor,
          actions: [
            ProfileUser(),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: ColorsApplication.primaryColor,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.4,
                maxHeight: MediaQuery.of(context).size.height * 0.9),
            child: Column(
              children: [
                Row(
                  children: [
                    IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: WelcomeApplication(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                MyCards(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileUser extends StatelessWidget {
  ProfileUser();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderGeneralInfos>(
      builder: (context, providerForm, child) => Stack(children: [
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _userImage(providerForm.userLogin ?? User.newUser()),
          ),
          onTap: () {
            _openUserEdit(context, providerForm.userLogin ?? User.newUser());
          },
        ),
      ]),
    );
  }

  void _openUserEdit(context, User user) {
    Navigator.of(context)
        .push(
      NavigationTransition.createRoute(
        FormRegisterUserScreen(user),
      ),
    )
        .then((user) {
      print(user);
      if (user != null) {
        Provider.of<ProviderGeneralInfos>(context, listen: false)
            .updateUserLogin(user);
      }
    });
  }

  Widget _userImage(User user) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: ColorsApplication.greenColor,
      child: user.urlProfilePhoto.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                user.urlProfilePhoto,
                width: 20,
                height: 20,
                fit: BoxFit.fitHeight,
              ),
            )
          : Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Icon(
                Icons.account_circle_sharp,
                color: ColorsApplication.primaryColor,
                // size: 100,
              ),
            ),
    );
  }
}
