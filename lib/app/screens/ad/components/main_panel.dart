import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/helpers/extensions.dart';

class MainPanel extends StatelessWidget {
  MainPanel(this.ad);
  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 14),
          child: Text(
            ad.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.titleColors,
            ),
          ),
        ),
        Text(
          ad.price.formattedMoney(),
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
            color: AppColors.titleColors,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 14),
          child: Text(
            'Publicado em ${ad.createdDate.formattedDate()}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
