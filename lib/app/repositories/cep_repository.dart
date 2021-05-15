import 'package:dio/dio.dart';
import 'package:works/app/models/address.dart';
import 'package:works/app/models/city.dart';
import 'package:works/app/repositories/ibge_repository.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.isEmpty) return Future.error('CEP Inválido');

    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');

    if (clearCep.length != 8) return Future.error('CEP Inválido');

    final url = 'https://viacep.com.br/ws/$clearCep/json';

    try {
      final response = await Dio().get<Map>(url);
      print(response);
      if (response.data.containsKey('erro') && response.data['erro'])
        return Future.error('CEP Inválido');

      final ufList = await IbgeReposity().getUFList();

      return Address(
        uf: ufList.firstWhere((uf) => uf.initials == response.data['uf']),
        city: City(name: response.data['localidade']),
        cep: response.data['cep'],
        district: response.data['bairro'],
      );
    } catch (e) {
      return Future.error('Falha ao buscar CEP');
    }
  }
}
