import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  const PageTile({this.label, this.iconData, this.onTap, this.highlighted});

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: highlighted ? Theme.of(context).primaryColor : Colors.black54,
        ),
      ),
      leading: Icon(
        iconData,
        color: highlighted ? Theme.of(context).primaryColor : Colors.black54,
      ),
      onTap: onTap,
    );
  }
}
