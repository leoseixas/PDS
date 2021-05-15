import 'package:flutter/material.dart';

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
              color: Color(0xFF04ADBF),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
