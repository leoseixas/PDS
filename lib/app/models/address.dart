import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';

class Address {
  Address({this.uf, this.city, this.district});

  UF uf;
  City city;
  String district;

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, district: $district}';
  }
}
