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
      future: _webClient.findUser(1),
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
            ProfileUser(user ?? User.newUser()),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: ColorsApplication.primaryColor,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.4,
                maxHeight: MediaQuery.of(context).size.height),
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
  final User user;
  ProfileUser(this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Icon(
          Icons.account_circle_sharp,
        ),
      ),
      onTap: () {
        _openUserEdit(context);
      },
    );
  }

  void _openUserEdit(context) {
    Navigator.of(context)
        .push(
      NavigationTransition.createRoute(
        FormRegisterUserScreen(user),
      ),
    )
        .then((user) {
      if (user != null) {
        Provider.of<ProviderGeneralInfos>(context, listen: false)
            .updateUserLogin(user);
      }
    });
  }
}
