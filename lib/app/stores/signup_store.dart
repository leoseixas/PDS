import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/helpers/extensions.dart';
import 'package:works/app/models/user.dart';
import 'package:works/app/repositories/user_respository.dart';
import 'package:works/app/stores/user_manager_store.dart';
part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String name = '';

  @action
  setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 6;
  String get nameError {
    if (nameValid || !showErrors)
      return null;
    else if (name.isEmpty)
      return 'Campo Obrigatorio';
    else
      return 'Nome muito curto';
  }

  @observable
  String email = '';
  @action
  setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (!showErrors || emailValid)
      return null;
    else if (email.isEmpty)
      return 'Campo obrigatório';
    else
      return 'E-mail inválido';
  }

  @observable
  String phone = '';

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (phoneValid || !showErrors)
      return null;
    else if (phone.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Celular inválido';
  }

  @observable
  String pass1 = '';
  @action
  setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1.length >= 6;
  String get pass1Error {
    if (!showErrors || pass1Valid)
      return null;
    else if (pass1.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Senha inválido';
  }

  @observable
  String pass2 = '';
  @action
  setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2 == pass1;
  String get pass2Error {
    if (!showErrors || pass2Valid)
      return null;
    else
      return 'Senha incorreta';
  }

  @computed
  bool get isFormValid =>
      nameValid && emailValid && phoneValid && pass1Valid && pass2Valid;

  @computed
  Function get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool savedAccount = false;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _signUp() async {
    loading = true;

    final user = User(name: name, email: email, phone: phone, password: pass1);

    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
      savedAccount = true;
    } catch (e) {
      error = e;
    }

    loading = false;
  }
}
