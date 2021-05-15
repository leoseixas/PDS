import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onPressed, this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 20, bottom: 12),
          child: RaisedButton(
            color: Colors.orange,
            disabledColor: Colors.orange.withAlpha(120),
            child: Text(label),
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
