import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/custom_drawer/custom_drawer.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/screens/create_ad/components/category_field.dart';
import 'package:works/app/screens/create_ad/components/location_field_ad.dart';
import 'package:works/app/stores/create_ad_store.dart';
import 'package:works/app/stores/page_store.dart';
import 'components/images_field.dart';

class CreateAdScreen extends StatefulWidget {
  CreateAdScreen({this.ad});

  final Ad ad;

  @override
  _CreateAdScreenState createState() => _CreateAdScreenState(ad);
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  _CreateAdScreenState(Ad ad)
      : editing = ad != null,
        createAdStore = CreateAdStore(ad ?? Ad());

  final CreateAdStore createAdStore;

  bool editing;

  @override
  void initState() {
    super.initState();

    when((_) => createAdStore.savedAd, () {
      if (editing)
        Navigator.of(context).pop(true);
      else {
        GetIt.I<PageStore>().setPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: editing ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text(editing ? 'Editar Anúncio' : 'Criar Anúncio'),
      ),
      body: Observer(
        builder: (_) {
          if (createAdStore.loading)
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              child: Card(
                elevation: 8,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Color(0xFFFF775B)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Salvando Anúncio',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF04ADBF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          else
            return Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ImagesField(createAdStore),
                        SizedBox(height: 16),
                        FieldTitle(title: 'Titulo'),
                        Observer(builder: (_) {
                          return TextFormField(
                            initialValue: createAdStore.title,
                            onChanged: createAdStore.setTitle,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: contentPadding,
                              errorText: createAdStore.titleError,
                            ),
                          );
                        }),
                        SizedBox(height: 16),
                        FieldTitle(title: 'Descrição'),
                        Observer(builder: (_) {
                          return TextFormField(
                            initialValue: createAdStore.description,
                            onChanged: createAdStore.setDescription,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: contentPadding,
                              errorText: createAdStore.descriptionError,
                            ),
                            maxLines: null,
                          );
                        }),
                        SizedBox(height: 16),
                        FieldTitle(title: 'Categorias'),
                        CategoryField(createAdStore),
                        SizedBox(height: 16),
                        LocationFieldAd(createAdStore),
                        SizedBox(height: 16),
                        FieldTitle(title: 'Preço'),
                        Observer(
                          builder: (_) {
                            return TextFormField(
                              initialValue: createAdStore.priceText,
                              onChanged: createAdStore.setPrice,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: contentPadding,
                                errorText: createAdStore.priceError,
                                prefixText: 'R\$ ',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(centavos: true),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        Observer(builder: (_) {
                          return ErrorBox(
                            message: createAdStore.error,
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            height: 48,
                            margin: const EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: createAdStore.invalidSendPressed,
                              child: RaisedButton(
                                color: AppColors.kSecondaryColor,
                                disabledColor: AppColors.kSecondaryColorLight,
                                child: Text(
                                  editing ? 'Editar' : 'Enviar',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: createAdStore.sendPressed,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
