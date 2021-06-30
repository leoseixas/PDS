import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/base/base_screen.dart';
import 'package:works/app/screens/login/login_screen.dart';
import 'package:works/app/screens/offline/offline_screen.dart';
import 'package:works/app/stores/connectivity_store.dart';
import 'package:works/app/stores/user_manager_store.dart';

class SplashIntroScreen extends StatefulWidget {
  @override
  _SplashIntroScreenState createState() => _SplashIntroScreenState();
}

class _SplashIntroScreenState extends State<SplashIntroScreen> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Observer(builder: (_) {
            return SplashScreen(
              seconds: 3,
              backgroundColor: AppColors.kPrimaryColor,
              navigateAfterSeconds: !connectivityStore.connected
                  ? OfflineScreen()
                  : userManagerStore.user != null
                      ? BaseScreen()
                      : LoginScreen(),
              loaderColor: Colors.transparent,
            );
          }),
          Center(
            child: Image.asset('assets/icons/logoapp.png', width: 200),
          )
        ],
      ),
    );
  }
}
