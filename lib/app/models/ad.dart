import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:works/app/models/address.dart';
import 'package:works/app/models/category.dart';
import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';
import 'package:works/app/models/user.dart';
import 'package:works/app/repositories/tables_keys.dart';
import 'package:works/app/repositories/user_respository.dart';

// enum AdStatus { PENDING, ACTIVE, DELETED }

class Ad {
  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages).map((e) => e.url).toList();
    price = object.get<num>(keyAdPrice);
    createdDate = object.createdAt;
    address = Address(
      city: City(name: object.get<String>(keyAdCity)),
      uf: UF(
        initials: object.get<String>(keyAdFederativeUnit),
        name: object.get<String>(keyAdState),
      ),
    );
    views = object.get<int>(keyAdViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(object.get<ParseUser>(keyAdOwner));
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
    // adStatus = AdStatus.values[object.get<int>(keyAdStatus)];
  }

  Ad();

  String id;
  List images = [];
  String title;
  String description;
  Category category;
  Address address;
  num price;

  // AdStatus adStatus = AdStatus.ACTIVE;
  DateTime createdDate;

  User user;
  int views;
}
