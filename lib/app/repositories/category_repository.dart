import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:works/app/models/category.dart';
import 'package:works/app/repositories/parse_erros.dart';
import 'package:works/app/repositories/tables_keys.dart';

class CategoryRepository {
  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((p) => Category.fromParse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
