import 'package:flutter/material.dart';

class CustomBottonGoogle extends StatelessWidget {
  const CustomBottonGoogle({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Image.asset(
                'assets/icons/google.png',
                width: 32,
              ),
            ),
            Text(
              'Entrar com google',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
