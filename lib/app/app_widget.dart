import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/screens/login/login_screen.dart';
import 'package:works/app/stores/user_manager_store.dart';

class AppWidget extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Works',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF04ADBF),
        secondaryHeaderColor: Color(0xFFFF775B),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFFFF775B),
        ),
        scaffoldBackgroundColor: Color(0xFFEEF4F6),
      ),
      home: LoginScreen(),
    );
  }
}
