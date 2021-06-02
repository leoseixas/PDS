import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/stores/recover_password_store.dart';

class RecoverPassword extends StatefulWidget {
  RecoverPassword(this.email);
  final String email;

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState(email);
}

class _RecoverPasswordState extends State<RecoverPassword> {
  _RecoverPasswordState(String email)
      : recoverStore = RecoveryPasswordStore(email);

  final RecoveryPasswordStore recoverStore;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => recoverStore.success, (s) {
      if (s)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Link de recuperação enviado para o E-mail informado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.kPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Recuperar Senha'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Observer(builder: (_) {
              if (recoverStore.error != null)
                return ErrorBox(message: recoverStore.error);
              else
                return Container();
            }),
            Text(
              'Esqueceu sua senha?',
              style: TextStyle(
                color: Color(0xFF787171),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Text(
                  'Não se preocupe! Insira o seu email de cadastro e enviaremos '
                  'instruções para você.',
                  style: TextStyle(
                    color: Color(0xFF787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Observer(builder: (_) {
                  return TextFormField(
                    initialValue: recoverStore.email,
                    enabled: !recoverStore.loading,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'E-mail',
                      errorText: recoverStore.emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: recoverStore.setEmail,
                  );
                }),
                Observer(builder: (_) {
                  return GestureDetector(
                    onTap: recoverStore.invalidSendPressed,
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 20, bottom: 12),
                      child: ElevatedButton(
                        onPressed: recoverStore.recoverPressed,
                        child: recoverStore.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'Recuperar senha',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.disabled)
                                    ? Colors.white
                                    : Colors.white,
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.disabled)
                                    ? AppColors.kSecondaryColorLight
                                    : AppColors.kSecondaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
