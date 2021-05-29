import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/helpers/extensions.dart';
import 'package:works/app/repositories/user_respository.dart';
import 'package:works/app/stores/user_manager_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
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
  String password = '';
  @action
  setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError {
    if (!showErrors || passwordValid)
      return null;
    else if (password.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Senha inválido';
  }

  @computed
  bool get isFormValid => emailValid && passwordValid;

  @computed
  Function get loginPressed => isFormValid && !loading ? _login : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @observable
  String error;

  @action
  Future<void> _login() async {
    loading = true;
    error = null;
    try {
      final user = await UserRepository().loginWithEmail(email, password);
      GetIt.I<UserManagerStore>().setUser(user);
      loggedIn = true;
    } catch (e) {
      error = e;
    }

    loading = false;
  }
}
