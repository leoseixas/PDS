import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/models/address.dart';
import 'package:works/app/models/category.dart';
import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';
import 'package:works/app/repositories/ad_repository.dart';
import 'package:works/app/repositories/ibge_repository.dart';
import 'package:works/app/stores/user_manager_store.dart';
part 'create_ad_store.g.dart';

class CreateAdStore = _CreateAdStore with _$CreateAdStore;

abstract class _CreateAdStore with Store {
  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (!showErrors || imagesValid)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 6;
  String get titleError {
    if (!showErrors || titleValid)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  bool get descriptionValid => description.length >= 10;
  String get descriptionError {
    if (!showErrors || descriptionValid)
      return null;
    else if (description.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Descrição muito curto';
  }

  @observable
  Category category;

  @action
  setCategory(Category value) => category = value;

  @computed
  bool get categoryvalid => category != null;
  String get categoryError {
    if (!showErrors || categoryvalid)
      return null;
    else
      return 'Campo obrigatório';
  }

  @observable
  Address address;

  @action
  void setAddress(Address value) => address = value;

  @action
  Future<void> getAddress(City city) async {
    try {
      address = await IbgeReposity().getAddressFromApi(city.id);
      setAddress(address);
      error = null;
    } catch (e) {
      error = e;
      setAddress(null);
    }
  }

  @computed
  bool get addressValide => address != null;
  String get addressError {
    if (!showErrors || addressValide)
      return null;
    else
      return 'Campo obrigatório';
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValide => price != null && price <= 9999999;
  String get priceError {
    if (!showErrors || priceValide)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Preço inválido';
  }

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryvalid &&
      addressValide &&
      priceValide;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  UF uf;

  @action
  void setUf(UF value) => uf = value;

  @observable
  City city;

  @action
  void setCity(City value) => city = value;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool savedAd = false;

  @action
  Future<void> _send() async {
    final ad = Ad();
    ad.images = images;
    ad.title = title;
    ad.description = description;
    ad.category = category;
    ad.address = address;
    ad.price = price;
    ad.user = GetIt.I<UserManagerStore>().user;

    loading = true;

    try {
      await AdRepository().saveAd(ad);
      savedAd = true;
    } catch (e) {
      error = e;
    }

    loading = false;
  }
}
