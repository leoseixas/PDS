import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';

class Address {
  Address({this.uf, this.city, this.cep, this.district});

  UF uf;
  City city;
  String cep;
  String district;

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, district: $district}';
  }
}
