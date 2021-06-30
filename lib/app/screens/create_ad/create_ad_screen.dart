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
import 'package:works/app/screens/edit_account/edit_account.dart';
import 'package:works/app/stores/create_ad_store.dart';
import 'package:works/app/stores/page_store.dart';
import 'package:works/app/stores/user_manager_store.dart';
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
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

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
          if (userManagerStore.user.phone == null)
            return Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    children: [
                      Text(
                        'Você ainda não tem um telefone cadastrado ',
                        style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                        child: Text(
                          'Cadastre!',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue[900],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditAccount()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          return Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImagesField(createAdStore),
                    SizedBox(height: 16),
                    FieldTitle(
                      title: 'Categorias',
                      color: AppColors.kPrimaryColor,
                    ),
                    CategoryField(createAdStore),
                    SizedBox(height: 16),
                    LocationFieldAd(createAdStore),
                    SizedBox(height: 16),
                    FieldTitle(
                      title: 'Titulo',
                      color: AppColors.kPrimaryColor,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createAdStore.title,
                        onChanged: createAdStore.setTitle,
                        maxLength: 30,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                            counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: contentPadding,
                          errorText: createAdStore.titleError,
                        ),
                      );
                    }),
                    SizedBox(height: 16),
                    FieldTitle(
                      title: 'Descrição',
                      color: AppColors.kPrimaryColor,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createAdStore.description,
                        onChanged: createAdStore.setDescription,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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

                    FieldTitle(
                      title: 'Preço',
                      color: AppColors.kPrimaryColor,
                    ),
                    Observer(
                      builder: (_) {
                        return TextFormField(
                          initialValue: createAdStore.priceText,
                          onChanged: createAdStore.setPrice,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                          child: ElevatedButton(
                            onPressed: createAdStore.sendPressed,
                            child: createAdStore.loading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.kPrimaryColor),
                                  )
                                : Text(
                                    editing ? 'Editar' : 'Enviar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    states.contains(MaterialState.disabled)
                                        ? AppColors.kPrimaryColor
                                        : AppColors.kPrimaryColor,
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    states.contains(MaterialState.disabled)
                                        ? AppColors.kSecondaryColorLight
                                        : AppColors.kSecondaryColor,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
