import 'package:get_it/get_it.dart';
import 'package:works/app/stores/category_store.dart';
import 'package:works/app/stores/connectivity_store.dart';
import 'package:works/app/stores/home_store.dart';
import 'package:works/app/stores/page_store.dart';
import 'package:works/app/stores/favorite_store.dart';
import 'package:works/app/stores/user_manager_store.dart';

class Setuplocators {
  void setupLocators() {
    GetIt.I.registerSingleton(ConnectivityStore());
    GetIt.I.registerSingleton(PageStore());
    GetIt.I.registerSingleton(UserManagerStore());
    GetIt.I.registerSingleton(HomeStore());
    GetIt.I.registerSingleton(CategoryStore());
    GetIt.I.registerSingleton(FavoriteStore());
  }
}
