import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/category.dart';
import 'package:works/app/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({this.showAll = true, this.selected});

  final Category selected;
  final bool showAll;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Observer(
          builder: (_) {
            if (categoryStore.categoryList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              final categories = showAll
                  ? categoryStore.allCategoryList
                  : categoryStore.categoryList;
              return ListView.separated(
                padding: EdgeInsets.all(8),
                separatorBuilder: (_, __) {
                  return Divider(
                    height: 0.1,
                    color: Colors.grey,
                  );
                },
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  final category = categories[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        height: 50,
                        color: category.id == selected?.id
                            ? AppColors.kSecondaryColor
                            : null,
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.kPrimaryColor,
                            fontWeight: category.id == selected?.id
                                ? FontWeight.w500
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
