import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';

class Address {
  Address({this.uf, this.city});

  UF uf;
  City city;

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city}';
  }
}
