import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/uf_city/uf_city_screen.dart';
import 'package:works/app/stores/create_ad_store.dart';

class LocationFieldAd extends StatelessWidget {
  LocationFieldAd(this.adStore);

  final CreateAdStore adStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FieldTitle(
              title: 'Localização',
            ),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => UfCityScreen()));
                if (result == null) return;
                adStore.setUf(result['uf']);
                adStore.setCity(result['city']);
                adStore.getAddress(adStore.city);
              },
              child: Card(
                shape: adStore.addressError == null
                    ? RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      )
                    : RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.red[700], width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                elevation: 0,
                margin: EdgeInsets.all(0),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(16),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.grey),
                  //   borderRadius: const BorderRadius.all(Radius.circular(5)),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        adStore.uf?.name ?? 'Selecionar Estado',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (adStore.addressError != null)
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  adStore.addressError,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            if (adStore.city != null)
              GestureDetector(
                onTap: () async {
                  final result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => UfCityScreen(
                                uf: adStore.uf,
                              )));
                  if (result == null) return;
                  adStore.setUf(result['uf']);
                  adStore.setCity(result['city']);
                  adStore.getAddress(adStore.city);
                },
                child: Card(
                  shape: adStore.addressError == null
                      ? RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        )
                      : RoundedRectangleBorder(
                          side:
                              new BorderSide(color: Colors.red[700], width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          adStore.city?.name ?? 'Selecionar Cidade',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
