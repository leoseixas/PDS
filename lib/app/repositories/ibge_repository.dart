import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:works/app/models/address.dart';
import 'package:works/app/models/city.dart';
import 'package:works/app/models/uf.dart';

class IbgeReposity {
  Future<List<UF>> getUFList() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('UF_LIST')) {
      final listJson = json.decode(preferences.get('UF_LIST'));

      return listJson.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort((UF a, UF b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }

    const url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(url);

      preferences.setString('UF_LIST', json.encode(response.data));

      return response.data.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } on DioError {
      return Future.error('Falha ao obter lista de Estado');
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final String url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      final response = await Dio().get<List>(url);

      final cityList = response.data
          .map<City>((json) => City.fromJson(json))
          .toList()
            ..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      print(cityList);
      return cityList;
    } on DioError {
      return Future.error('Falha ao obter lista de Cidades');
    }
  }

  Future<Address> getAddressFromApi(int idCity) async {
    if (idCity == null) return Future.error('Nenhuma cidade encontrada!');

    final url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/municipios/$idCity';

    try {
      final response = await Dio().get<Map>(url);
      print(response);
      if (response.data.containsKey('erro') && response.data['erro'])
        return Future.error('Cidade Inválido');

      return Address(
        uf: UF(
          id: response.data['microrregiao']['mesorregiao']['UF']['id'],
          initials: response.data['microrregiao']['mesorregiao']['UF']['sigla'],
          name: response.data['microrregiao']['mesorregiao']['UF']['nome'],
        ),
        city: City(
          id: response.data['id'],
          name: response.data['nome'],
        ),
      );
    } catch (e) {
      return Future.error('Falha ao buscar Endereço');
    }
  }
}
