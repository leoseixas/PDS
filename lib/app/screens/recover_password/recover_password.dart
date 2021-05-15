import 'package:flutter/material.dart';
import 'package:works/app/components/custom_botton/custom_button.dart';

class RecoverPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Senha'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Card(
          color: Colors.white,
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
                  'Esqueceu sua senha?',
                  style: TextStyle(
                    color: Color(0xFF787171),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                TextField(
                  // enabled: !signupStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'E-mail',
                    // errorText: signupStore.emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // onChanged: signupStore.setName,
                ),
                CustomButton(
                  label: 'Entrar',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
