import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/splash/splash_intro_screen.dart';
import 'package:works/app/stores/connectivity_store.dart';
import 'package:works/app/stores/user_manager_store.dart';

class AppWidget extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Works',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.kPrimaryColor,
        secondaryHeaderColor: Color(0xFFFF775B),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFFFF775B),
        ),
        accentColor: AppColors.kSecondaryColor,
        // scaffoldBackgroundColor: Color(0xFFEEF4F6),
        scaffoldBackgroundColor: Colors.white,
      ),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: SplashIntroScreen(),
    );
  }
}
