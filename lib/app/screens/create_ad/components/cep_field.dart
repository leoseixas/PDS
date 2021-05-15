import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/stores/cep_store.dart';
import 'package:works/app/stores/create_ad_store.dart';

class CepField extends StatelessWidget {
  CepField(this.createAdStore) : cepStore = createAdStore.cepStore;

  final CreateAdStore createAdStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_) {
          return TextFormField(
            onChanged: cepStore.setCep,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                errorText: createAdStore.addressError),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
          );
        }),
        Observer(builder: (_) {
          if (cepStore.address == null &&
              cepStore.error == null &&
              !cepStore.loading)
            return Container();
          else if (cepStore.address == null && cepStore.error == null)
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFFFF775B)),
                  backgroundColor: Colors.transparent,
                ),
              ],
            );
          else if (cepStore.error != null)
            return Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.withAlpha(100),
              ),
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepStore.error,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          else {
            final a = cepStore.address;

            return Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF04ADBF),
              ),
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Localização: ${a.district}, ${a.city.name} - ${a.uf.initials}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        }),
      ],
    );
  }
}
