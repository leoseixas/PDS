import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/screens/filter/components/price_field.dart';
import 'package:works/app/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  PriceRangeField(this.filter);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldTitle(title: 'Preço'),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChanged: filter.setMinPrice,
              initialValue: filter.minPrice,
            ),
            const SizedBox(width: 12),
            PriceField(
              label: 'Max',
              onChanged: filter.setMaxPrice,
              initialValue: filter.maxPrice,
            ),
          ],
        ),
        Observer(builder: (_) {
          if (filter.priceError != null)
            return Padding(
              padding: const EdgeInsets.only(left: 5, top: 4.0),
              child: Text(
                filter.priceError,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          return Container();
        }),
      ],
    );
  }
}
