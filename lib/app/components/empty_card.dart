import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';

class EmptyCard extends StatelessWidget {
  EmptyCard(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.border_clear,
            size: 200,
            color: AppColors.kSecondaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
