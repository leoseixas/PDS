import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/custom_botton_google/custom_botton_google.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/base/base_screen.dart';
import 'package:works/app/screens/recover_password/recover_password.dart';
import 'package:works/app/screens/signup/signup_screen.dart';
import 'package:works/app/stores/login_store.dart';
import 'package:works/app/stores/user_manager_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    disposer = reaction(
      (_) => loginStore.loggedIn,
      (isLoggedIn) {
        if (isLoggedIn)
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BaseScreen(),
            ),
          );
      },
    );
    disposer = reaction(
      (_) => userManagerStore.user,
      (user) {
        if (user != null)
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BaseScreen(),
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF04ADBF),
                const Color(0xFFFF775B),
              ],
              begin: const FractionalOffset(0.5, 0.0),
              end: const FractionalOffset(0.9, 1.1),
              stops: [0.60, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Works',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  Observer(builder: (_) {
                    return ErrorBox(
                      message: loginStore.error,
                    );
                  }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldTitle(title: 'E-mail'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !loginStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: loginStore.emailError,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                        );
                      }),
                      SizedBox(height: 16),
                      FieldTitle(title: 'Senha'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !loginStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: loginStore.passwordError,
                          ),
                          obscureText: true,
                          onChanged: loginStore.setPassword,
                        );
                      }),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(top: 8, right: 4),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RecoverPassword()));
                        },
                      ),
                      Observer(builder: (_) {
                        return Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 20, bottom: 12),
                          child: RaisedButton(
                            color: AppColors.kSecondaryColor,
                            disabledColor: AppColors.kSecondaryColorLight,
                            child: loginStore.loading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: loginStore.loginPressed,
                          ),
                        );
                      }),
                      Divider(color: Colors.black54),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: CustomBottonGoogle(
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Wrap(
                    children: [
                      Text(
                        'Ainda não tem uma conta? ',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Cadastre-se!',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.orange,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
