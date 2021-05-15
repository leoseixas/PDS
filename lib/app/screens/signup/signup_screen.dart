import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/components/custom_botton_google/custom_botton_google.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Observer(
                        builder: (_) {
                          return ErrorBox(
                            message: signupStore.error,
                          );
                        },
                      ),
                      FieldTitle(title: 'Nome'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: signupStore.nameError,
                          ),
                          onChanged: signupStore.setName,
                        );
                      }),
                      SizedBox(height: 16),
                      FieldTitle(title: 'E-mail'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: signupStore.emailError,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: signupStore.setEmail,
                        );
                      }),
                      SizedBox(height: 16),
                      FieldTitle(title: 'Telefone'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: signupStore.phoneError,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          keyboardType: TextInputType.phone,
                          onChanged: signupStore.setPhone,
                        );
                      }),
                      SizedBox(height: 16),
                      FieldTitle(title: 'Senha'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: signupStore.pass1Error,
                          ),
                          obscureText: true,
                          onChanged: signupStore.setPass1,
                        );
                      }),
                      SizedBox(height: 16),
                      FieldTitle(title: 'Senha novamente'),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            errorText: signupStore.pass2Error,
                          ),
                          obscureText: true,
                          onChanged: signupStore.setPass2,
                        );
                      }),
                    ],
                  ),
                  Observer(builder: (_) {
                    return Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20, bottom: 12),
                      child: RaisedButton(
                        onPressed: signupStore.signUpPressed,
                        color: Colors.orange,
                        disabledColor: Colors.orange.withAlpha(120),
                        child: signupStore.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'Cadastrar',
                                style: TextStyle(fontSize: 18),
                              ),
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                  SizedBox(height: 50),
                  Wrap(
                    children: [
                      Text(
                        'Já possui uma conta? ',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Entre!',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.orange,
                          fontSize: 14,
                        ),
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
}
