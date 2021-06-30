import 'package:flutter/material.dart';
import 'package:works/app/components/custom_drawer/custom_drawer_header.dart';
import 'package:works/app/components/custom_drawer/page_section.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(30),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Drawer(
            child: ListView(
              children: [
                CustomDrawerHeader(),
                Divider(),
                PageSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
