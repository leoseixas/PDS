import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/components/error_box.dart';
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
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          margin: const EdgeInsets.all(12),
          child: Observer(
            builder: (_) {
              if (categoryStore.error != null) {
                return ErrorBox(
                  message: categoryStore.error,
                );
              } else if (categoryStore.categoriesList.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoriesList;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    separatorBuilder: (_, __) {
                      return Divider(
                        height: 0.1,
                        color: Colors.grey,
                      );
                    },
                    itemCount: categories.length,
                    itemBuilder: (_, index) {
                      final category = categories[index];
                      return InkWell(
                        // customBorder: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        onTap: () {
                          Navigator.of(context).pop(category);
                        },
                        child: Container(
                          height: 50,
                          color: category.id == selected?.id
                              ? Colors.orange.withAlpha(50)
                              : null,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            category.description,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: category.id == selected?.id
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
