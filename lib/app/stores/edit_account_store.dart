import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/models/user.dart';
import 'package:works/app/repositories/user_respository.dart';
import 'package:works/app/stores/user_manager_store.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    user = userManagerStore.user;

    name = user.name;
    phone = user.phone;
  }
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  User user;

  @observable
  String name;

  @action
  setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 6;
  String get nameError =>
      nameValid || name == null ? null : 'Campo obrigatorio';

  @observable
  String phone;

  @action
  setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError =>
      phoneValid || phone == null ? null : 'Campo obrigatório';

  @observable
  String pass1 = '';

  @action
  setPass1(String value) => pass1 = value;

  @observable
  String pass2 = '';

  @action
  setPass2(String value) => pass2 = value;

  @computed
  bool get passValid => pass2 == pass1 && (pass1.length >= 6 || pass1.isEmpty);
  String get passError {
    if (pass1.isNotEmpty && pass1.length < 6)
      return 'Senha muito curta';
    else if (pass1 != pass2) return 'Senhas não coincidem';
    return null;
  }

  @computed
  bool get isFormValid => nameValid && phoneValid && passValid;

  @observable
  bool loading = false;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @observable
  bool savedUser = false;

  @action
  Future<void> _save() async {
    loading = true;

    user.name = name;
    user.phone = phone;

    if (pass1.isNotEmpty)
      user.password = pass1;
    else
      user.password = null;

    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
      savedUser = true;
    } catch (e) {
      print(e);
    }
    loading = false;
  }
}
