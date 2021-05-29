import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/stores/edit_account_store.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final EditAccountStore editAccountStore = EditAccountStore();

  @override
  void initState() {
    super.initState();
    when((_) => editAccountStore.savedUser, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar conta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldTitle(title: 'Nome'),
              Observer(builder: (_) {
                return TextFormField(
                  initialValue: editAccountStore.name,
                  enabled: !editAccountStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    errorText: editAccountStore.nameError,
                  ),
                  onChanged: editAccountStore.setName,
                );
              }),
              SizedBox(height: 16),
              FieldTitle(title: 'Telefone'),
              Observer(builder: (_) {
                return TextFormField(
                  initialValue: editAccountStore.phone,
                  enabled: !editAccountStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    errorText: editAccountStore.phoneError,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  keyboardType: TextInputType.phone,
                  onChanged: editAccountStore.setPhone,
                );
              }),
              SizedBox(height: 16),
              FieldTitle(title: 'Nova senha'),
              Observer(builder: (_) {
                return TextField(
                  enabled: !editAccountStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    errorText: editAccountStore.passError,
                  ),
                  obscureText: true,
                  onChanged: editAccountStore.setPass1,
                );
              }),
              SizedBox(height: 16),
              FieldTitle(title: 'Senha novamente'),
              Observer(builder: (_) {
                return TextField(
                  enabled: !editAccountStore.loading,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    errorText: editAccountStore.passError,
                  ),
                  obscureText: true,
                  onChanged: editAccountStore.setPass2,
                );
              }),
              Observer(builder: (_) {
                return Container(
                  height: 45,
                  margin: const EdgeInsets.only(top: 20, bottom: 25),
                  child: RaisedButton(
                    onPressed: editAccountStore.savePressed,
                    color: AppColors.kSecondaryColor,
                    disabledColor: AppColors.kSecondaryColorLight,
                    child: editAccountStore.loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            'Salvar alteração',
                            style: TextStyle(fontSize: 18),
                          ),
                    textColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}