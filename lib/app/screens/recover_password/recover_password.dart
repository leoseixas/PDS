import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                Container(
                  height: 45,
                  margin: const EdgeInsets.only(top: 20, bottom: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: RaisedButton(
                      onPressed: () {},
                      color: AppColors.kSecondaryColor,
                      disabledColor: AppColors.kSecondaryColorLight,
                      child: Text(
                        'Recuperar',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
