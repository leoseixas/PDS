import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/screens/create_ad/create_ad_screen.dart';
import 'package:works/app/screens/home/home_screen.dart';
import 'package:works/app/screens/favorites/favorites_screen.dart';
import 'package:works/app/screens/offline/offline_screen.dart';
import 'package:works/app/screens/perfil/perfil_screen.dart';
import 'package:works/app/stores/connectivity_store.dart';
import 'package:works/app/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();

  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));

    autorun((_) {
      if (!connectivityStore.connected) {
        showDialog(context: context, builder: (_) => OfflineScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeScreen(),
          CreateAdScreen(),
          FavoritesScreen(),
          PerfilScreen(),
        ],
      ),
    );
  }
}
