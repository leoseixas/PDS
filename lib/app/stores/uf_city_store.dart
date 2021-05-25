import 'package:diacritic/diacritic.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/models/address.dart';
import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';
import 'package:works/app/repositories/ibge_repository.dart';
part 'uf_city_store.g.dart';

class UfCityStore = _UfCityStore with _$UfCityStore;

abstract class _UfCityStore with Store {
  _UfCityStore({UF uf, this.showAll}) {
    setItem(uf);
  }

  final IbgeReposity ibge = IbgeReposity();

  bool showAll;

  ObservableList outList = ObservableList();

  @action
  void setOutList(List items) {
    outList.addAll(items);
  }

  @observable
  String search = "";

  @action
  void setSearch(String value) =>
      search = removeDiacritics(value.toLowerCase());

  @observable
  UF uf;

  @observable
  City city;

  @action
  Future<void> setItem(dynamic value) async {
    if (value == null) {
      uf = null;
      outList.clear();
      ibge.getUFList().then(setOutList).catchError(setError);
    } else if (uf == null) {
      uf = value;
      outList.clear();
      ibge.getCityListFromApi(uf).then(setOutList).catchError(setError);
    } else {
      city = value;

      // getAddress(city);
    }
    setSearch('');
  }

  // @action
  // Future<void> getAddress(City city) async {
  //   try {
  //     address = await ibge.getAddressFromApi(city.id);
  //     print(address);
  //     error = null;
  //   } catch (e) {
  //     error = e;
  //     address = null;
  //   }
  // }

  @computed
  List get outFiltered {
    if (search.isEmpty) if (!showAll)
      return outList;
    else if (uf == null)
      return List.from(outList)..insert(0, UF(name: 'Todos', id: -1));
    else
      return List.from(outList)..insert(0, City(name: 'Todas', id: -1));
    else
      return outList
          .where(
              (uf) => removeDiacritics(uf.name.toLowerCase()).contains(search))
          .toList();
  }

  @observable
  String error;

  void setError(var value) => error = value;

  @observable
  Address address;

  @action
  void setAddress(Address value) => address = value;
}
