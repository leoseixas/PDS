import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';
import 'package:works/app/stores/home_store.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore(
      {this.orderBy = OrderBy.DATE,
      this.minPrice,
      this.maxPrice,
      this.uf,
      this.city});

  @observable
  OrderBy orderBy;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @observable
  int maxPrice;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get priceError =>
      maxPrice != null && minPrice != null && maxPrice < minPrice
          ? 'Faixa de preço inválida'
          : null;

  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
      uf: uf,
      city: city,
    );
  }

  @observable
  UF uf;

  @action
  void setUf(UF value) => uf = value;

  @observable
  City city;

  @action
  void setCity(City value) => city = value;

  copyWith(
      {int minPrice,
      int maxPrice,
      OrderBy orderBy,
      int vendorType,
      UF uf,
      City city}) {
    return FilterStore(
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        orderBy: orderBy ?? this.orderBy,
        uf: uf ?? this.uf,
        city: city ?? this.city);
  }

  @override
  String toString() {
    return '$minPrice, $maxPrice, ${orderBy.toString()}, ${uf.initials}, $city';
  }
}
