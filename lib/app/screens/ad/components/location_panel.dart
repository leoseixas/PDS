import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';

class LocationPanel extends StatelessWidget {
  LocationPanel(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Colors.grey[700],
      fontSize: 16,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text(
            'Localização',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.titleColors,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cidade',
                      style: style,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Estado',
                      style: style,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ad.address.city.name,
                      style: style,
                    ),
                    SizedBox(height: 12),
                    Text(
                      ad.address.uf.name,
                      style: style,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
