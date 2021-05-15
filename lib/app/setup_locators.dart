import 'package:get_it/get_it.dart';
import 'package:works/app/stores/category_store.dart';
import 'package:works/app/stores/home_store.dart';
import 'package:works/app/stores/page_store.dart';
import 'package:works/app/stores/user_manager_store.dart';

class Setuplocators {
  void setupLocators() {
    GetIt.I.registerSingleton(PageStore());
    GetIt.I.registerSingleton(HomeStore());
    GetIt.I.registerSingleton(UserManagerStore());
    GetIt.I.registerSingleton(CategoryStore());
  }
}
