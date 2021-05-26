// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_ads_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyAdsStore on _MyAdsStore, Store {
  Computed<bool> _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_MyAdsStore.showProgress'))
          .value;

  final _$errorAtom = Atom(name: '_MyAdsStore.error');

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

  final _$loadingAtom = Atom(name: '_MyAdsStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$deleteAdAsyncAction = AsyncAction('_MyAdsStore.deleteAd');

  @override
  Future<void> deleteAd(Ad ad) {
    return _$deleteAdAsyncAction.run(() => super.deleteAd(ad));
  }

  final _$_MyAdsStoreActionController = ActionController(name: '_MyAdsStore');

  @override
  void setError(String value) {
    final _$actionInfo =
        _$_MyAdsStoreActionController.startAction(name: '_MyAdsStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_MyAdsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_MyAdsStoreActionController.startAction(
        name: '_MyAdsStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_MyAdsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
loading: ${loading},
showProgress: ${showProgress}
    ''';
  }
}
