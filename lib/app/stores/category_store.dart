import 'package:mobx/mobx.dart';
import 'package:works/app/models/category.dart';
import 'package:works/app/repositories/category_repository.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  _CategoryStore() {
    _loadCategories();
  }

  ObservableList<Category> categoriesList = ObservableList<Category>();

  @computed
  List<Category> get allCategoryList => List.from(categoriesList)
    ..insert(0, Category(id: '*', description: 'Todas'));

  @action
  void setCategories(List<Category> categories) {
    categoriesList.clear();
    categoriesList.addAll(categories);
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch (e) {
      setError(e);
    }
  }
}
