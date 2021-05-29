import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/components/custom_botton_google/custom_botton_google.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                  Observer(builder: (_) {
                    return Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 20, bottom: 12),
                      child: GestureDetector(
                        onTap: signupStore.invalidSendPressed,
                        child: RaisedButton(
                          onPressed: signupStore.signUpPressed,
                          color: AppColors.kSecondaryColor,
                          disabledColor: AppColors.kSecondaryColorLight,
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
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
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
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Text(
                      'Entre!',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.kSecondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
