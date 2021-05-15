import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/components/field_title/field_title.dart';
import 'package:works/app/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField(this.filter);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldTitle(title: 'Ordenar por'),
        const SizedBox(height: 8),
        Observer(
          builder: (_) {
            return Row(
              children: [
                _buildOption('Data', OrderBy.DATE),
                const SizedBox(width: 16),
                _buildOption('Preço', OrderBy.PRICE),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildOption(String title, OrderBy option) {
    return GestureDetector(
      onTap: () {
        filter.setOrderBy(option);
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              filter.orderBy == option ? Color(0xFF04ADBF) : Colors.transparent,
          border: Border.all(
            color: filter.orderBy == option ? Colors.transparent : Colors.grey,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: filter.orderBy == option ? Colors.white : Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
