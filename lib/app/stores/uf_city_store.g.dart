// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uf_city_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UfCityStore on _UfCityStore, Store {
  Computed<List<dynamic>> _$outFilteredComputed;

  @override
  List<dynamic> get outFiltered => (_$outFilteredComputed ??=
          Computed<List<dynamic>>(() => super.outFiltered,
              name: '_UfCityStore.outFiltered'))
      .value;

  final _$searchAtom = Atom(name: '_UfCityStore.search');

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$ufAtom = Atom(name: '_UfCityStore.uf');

  @override
  UF get uf {
    _$ufAtom.reportRead();
    return super.uf;
  }

  @override
  set uf(UF value) {
    _$ufAtom.reportWrite(value, super.uf, () {
      super.uf = value;
    });
  }

  final _$cityAtom = Atom(name: '_UfCityStore.city');

  @override
  City get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(City value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  final _$errorAtom = Atom(name: '_UfCityStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$addressAtom = Atom(name: '_UfCityStore.address');

  @override
  Address get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(Address value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$setItemAsyncAction = AsyncAction('_UfCityStore.setItem');

  @override
  Future<void> setItem(dynamic value) {
    return _$setItemAsyncAction.run(() => super.setItem(value));
  }

  final _$_UfCityStoreActionController = ActionController(name: '_UfCityStore');

  @override
  void setOutList(List<dynamic> items) {
    final _$actionInfo = _$_UfCityStoreActionController.startAction(
        name: '_UfCityStore.setOutList');
    try {
      return super.setOutList(items);
    } finally {
      _$_UfCityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearch(String value) {
    final _$actionInfo = _$_UfCityStoreActionController.startAction(
        name: '_UfCityStore.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_UfCityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(Address value) {
    final _$actionInfo = _$_UfCityStoreActionController.startAction(
        name: '_UfCityStore.setAddress');
    try {
      return super.setAddress(value);
    } finally {
      _$_UfCityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
uf: ${uf},
city: ${city},
error: ${error},
address: ${address},
outFiltered: ${outFiltered}
    ''';
  }
}
