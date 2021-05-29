import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/filter/components/location_field.dart';
import 'package:works/app/screens/filter/components/orderby_field.dart';
import 'package:works/app/screens/filter/components/price_range_field.dart';
import 'package:works/app/stores/filter_store.dart';
import 'package:works/app/stores/home_store.dart';

class FilterScreen extends StatelessWidget {
  final FilterStore filter = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LocationField(filter),
              const SizedBox(height: 16),
              OrderByField(filter),
              const SizedBox(height: 16),
              PriceRangeField(filter),
              const SizedBox(height: 16),
              Observer(
                builder: (_) {
                  return Container(
                    height: 45,
                    child: RaisedButton(
                      color: AppColors.kSecondaryColor,
                      disabledColor: AppColors.kSecondaryColorLight,
                      child: Text(
                        'Filtrar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: filter.isFormValid
                          ? () {
                              filter.save();
                              Navigator.of(context).pop();
                            }
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
