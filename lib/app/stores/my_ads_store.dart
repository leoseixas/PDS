import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/repositories/ad_repository.dart';
import 'package:works/app/stores/user_manager_store.dart';
part 'my_ads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    autorun((_) {
      final user = GetIt.I<UserManagerStore>().user;
      if (user != null) _getMyAds();
    });
  }

  List<Ad> myAdList = [];

  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user;
    try {
      setLoading(true);
      myAdList = await AdRepository().getMyAds(user);
      setError(null);
      setLoading(false);
    } catch (e) {
      setError(e);
    }
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @computed
  bool get showProgress => loading && myAdList.isEmpty;

  void refresh() async {
    loading = true;
    await _getMyAds();
    loading = false;
  }

  @action
  Future<void> deleteAd(Ad ad) async {
    loading = true;
    await AdRepository().delete(ad);
    refresh();
    loading = false;
  }
}
