import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                  FieldTitle(title: 'Nome', color: AppColors.kPrimaryColor),
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
                  FieldTitle(title: 'E-mail', color: AppColors.kPrimaryColor),
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
                  FieldTitle(title: 'Telefone', color: AppColors.kPrimaryColor),
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
                  FieldTitle(title: 'Senha', color: AppColors.kPrimaryColor),
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
                  FieldTitle(
                      title: 'Senha novamente', color: AppColors.kPrimaryColor),
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
                        child: ElevatedButton(
                          onPressed: signupStore.signUpPressed,
                          child: signupStore.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      AppColors.kPrimaryColor),
                                )
                              : Text(
                                  'Cadastrar',
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
                ],
              ),
              Divider(color: Colors.black54),
              SizedBox(height: 12),
              Wrap(
                children: [
                  Text(
                    'Já possui uma conta? ',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Text(
                      'Entre!',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey[500],
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
