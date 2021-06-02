import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/models/user.dart';
import 'package:works/app/repositories/user_respository.dart';

import 'connectivity_store.dart';
part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  _UserManagerStore() {
    getCurrentUser();
  }

  @observable
  User user;

  @action
  void setUser(User value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> getCurrentUser() async {
    final user = await UserRepository().currentUser();
    setUser(user);
  }

  @observable
  bool userLogged;

  @action
  Future<void> getUserLogged() async {
    final user = await UserRepository().hasUserLogged();
    userLogged = user;
  }

  Future<void> logout() async {
    await UserRepository().logout();
    setUser(null);
  }
}
