import 'package:flutter/material.dart';
import 'package:works/app/components/custom_drawer/custom_drawer.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      drawer: CustomDrawer(),
    );
  }
}
