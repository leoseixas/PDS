import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';

class BarButton extends StatelessWidget {
  BarButton({this.onTap, this.label, this.decoration});

  final VoidCallback onTap;
  final String label;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 48,
          decoration: decoration,
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.kSecondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
