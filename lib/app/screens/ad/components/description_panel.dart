import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';

class DescriptionPanel extends StatelessWidget {
  DescriptionPanel(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text(
            'Descrição',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.titleColors,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 14),
          child: ReadMoreText(
            ad.description,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimExpandedText: 'Menos',
            trimCollapsedText: 'Mais',
            colorClickableText: AppColors.kSecondaryColor,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}
