import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:works/app/screens/base/base_screen.dart';
import 'package:works/app/screens/login/login_screen.dart';
import 'package:works/app/stores/user_manager_store.dart';

class SplashIntroScreen extends StatefulWidget {
  @override
  _SplashIntroScreenState createState() => _SplashIntroScreenState();
}

class _SplashIntroScreenState extends State<SplashIntroScreen> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Observer(builder: (_) {
            return SplashScreen(
              seconds: 3,
              gradientBackground: new LinearGradient(
                colors: [
                  const Color(0xFF04ADBF),
                  const Color(0xFFFF775B),
                ],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.9, 1.1),
                stops: [0.60, 1.0],
                tileMode: TileMode.clamp,
              ),
              navigateAfterSeconds:
                  userManagerStore.user != null ? BaseScreen() : LoginScreen(),
              loaderColor: Colors.transparent,
            );
          }),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Works',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
