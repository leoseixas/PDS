import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/models/user.dart';
import 'package:works/app/repositories/parse_erros.dart';
import 'package:works/app/repositories/tables_keys.dart';

class FavoriteRepository {
  Future<List<Ad>> getFavoritesList(User user) async {
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyFavoriteTable));

    queryBuilder.whereEqualTo(keyFavoriteUser, user.id);
    queryBuilder.includeObject([keyFavoriteAd, 'ad.owner']);

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results
          .map((po) => Ad.fromParse(po.get(keyFavoriteAd)))
          .toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> save({Ad ad, User user}) async {
    final favoriteObject = ParseObject(keyFavoriteTable);

    favoriteObject.set<String>(keyFavoriteUser, user.id);
    favoriteObject.set<ParseObject>(
        keyFavoriteAd, ParseObject(keyAdTable)..set(keyAdId, ad.id));

    final response = await favoriteObject.save();
    if (!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<void> delete({Ad ad, User user}) async {
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyFavoriteTable));

      queryBuilder.whereEqualTo(keyFavoriteUser, user.id);
      queryBuilder.whereEqualTo(
          keyFavoriteAd, ParseObject(keyAdTable)..set(keyAdId, ad.id));

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        for (final favorite in response.results as List<ParseObject>) {
          await favorite.delete();
        }
      }
    } catch (e) {
      return Future.error('Falha ao deletar favorito');
    }
  }
}
