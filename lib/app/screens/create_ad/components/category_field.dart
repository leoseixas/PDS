import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/category/category_screen.dart';
import 'package:works/app/stores/create_ad_store.dart';

class CategoryField extends StatelessWidget {
  CategoryField(this.createAdStore);
  final CreateAdStore createAdStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            GestureDetector(
              child: Card(
                shape: createAdStore.categoryError == null
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
                  padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      createAdStore.category == null
                          ? Container(child: Text('Selecione Categoria'))
                          : Text(
                              '${createAdStore.category.description}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                      createAdStore.category == null
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.kPrimaryColor,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              onTap: () async {
                final category = await showDialog(
                  context: context,
                  builder: (_) => CategoryScreen(
                    showAll: false,
                    selected: createAdStore.category,
                  ),
                );
                if (category != null) {
                  createAdStore.setCategory(category);
                }
              },
            ),
            if (createAdStore.categoryError != null)
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  createAdStore.categoryError,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
