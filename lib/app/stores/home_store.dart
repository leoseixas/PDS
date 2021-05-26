import 'package:mobx/mobx.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/models/category.dart';
import 'package:works/app/repositories/ad_repository.dart';
import 'package:works/app/stores/filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  // _HomeStore() {
  // autorun((_) async {
  //   try {
  //     setLoading(true);
  //     final newAds = await AdRepository().getHomeAdList(
  //       filter: filter,
  //       search: search,
  //       category: category,
  //       page: page,
  //     );
  //     addNewAds(newAds);

  //     setError(null);
  //     setLoading(false);
  //   } catch (e) {
  //     setError(e);
  //   }
  // });

  //   autorun((_) {
  //     getListAds();
  //   });
  // }

  ObservableList<Ad> adList = ObservableList<Ad>();

  Future<void> getListAds() async {
    try {
      setLoading(true);
      final newAds = await AdRepository().getHomeAdList(
        filter: filter,
        search: search,
        category: category,
        page: page,
      );
      adList.clear();
      addNewAds(newAds);

      setError(null);
      setLoading(false);
    } catch (e) {
      setError(e);
    }
  }

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();

  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    resetPage();
    filter = value;
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void addNewAds(List<Ad> newAds) {
    if (newAds.length < 10) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  void refresh() => getListAds();

  @computed
  bool get showProgress => loading && adList.isEmpty;
}
