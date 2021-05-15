import 'package:flutter/material.dart';
import 'package:works/app/screens/filter/components/orderby_field.dart';
import 'package:works/app/screens/filter/components/price_range_field.dart';
import 'package:works/app/stores/filter_store.dart';

class FilterScreen extends StatelessWidget {
  final FilterStore filter = FilterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  OrderByField(filter),
                  const SizedBox(height: 16),
                  PriceRangeField(filter),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
