import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/custom_botton_facebook/custom_botton_facebook.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/base/base_screen.dart';
import 'package:works/app/screens/recover_password/recover_password.dart';
import 'package:works/app/screens/signup/signup_screen.dart';
import 'package:works/app/stores/connectivity_store.dart';
import 'package:works/app/stores/login_store.dart';
import 'package:works/app/stores/user_manager_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    userManagerStore.getCurrentUser();
  }

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
      backgroundColor: Color(0xFF3D4A73),
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6.5, left: 16, right: 16),
        children: [
          Image.asset('assets/icons/logoapp.png', height: 150,),
          SizedBox(height: 10),
          Observer(builder: (_) {
            return ErrorBox(
              message: loginStore.error,
            );
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldTitle(
                title: 'E-mail',
                color: AppColors.kSecondaryColor,
              ),
              Observer(builder: (_) {
                return TextField(
                  enabled: !loginStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
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
              FieldTitle(
                title: 'Senha',
                color: AppColors.kSecondaryColor,
              ),
              Observer(builder: (_) {
                return TextField(
                  enabled: !loginStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
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
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RecoverPassword(loginStore.email)));
                },
              ),
              Observer(builder: (_) {
                return Container(
                  height: 45,
                  margin: const EdgeInsets.only(top: 20, bottom: 12),
                  child: GestureDetector(
                    onTap: loginStore.invalidSendPressed,
                    child: ElevatedButton(
                      onPressed: loginStore.loginPressed,
                      child: loginStore.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.kPrimaryColor,
                              ),
                            )
                          : Text(
                              'Entrar',
                              style: TextStyle(fontSize: 18),
                            ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.disabled)
                                  ? AppColors.kPrimaryColor
                                  : AppColors.kPrimaryColor,
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.disabled)
                                  ? AppColors.kSecondaryColorLight
                                  : AppColors.kSecondaryColor,
                        ),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                    ),
                  ),
                );
              }),
              Divider(color: Colors.black54),
              Observer(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: CustomBottonFacebook(
                      onPressed: loginStore.facebookPressed,
                      loading: loginStore.loadingFace,
                      loginStore: loginStore,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                Text(
                  'Ainda não tem uma conta? ',
                  style: TextStyle(
                    color: AppColors.kSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    'Cadastre-se!',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
