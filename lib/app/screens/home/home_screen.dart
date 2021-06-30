import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/custom_drawer/custom_drawer.dart';
import 'package:works/app/components/empty_card.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/home/components/search_dialog.dart';
import 'package:works/app/screens/home/components/top_bar.dart';
import 'package:works/app/stores/category_store.dart';
import 'package:works/app/stores/connectivity_store.dart';
import 'package:works/app/stores/home_store.dart';

import 'components/ad_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  final CategoryStore categoryStore = GetIt.I<CategoryStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (_) => SearchDialog(
        currentSearch: homeStore.search,
      ),
    );
    if (search != null) homeStore.setSearch(search);
  }

  @override
  void initState() {
    super.initState();
    autorun((_) {
      if (connectivityStore.connected) homeStore.getListAds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.kSecondaryColorLight),
        title: Observer(builder: (_) {
          if (homeStore.search.isEmpty)
            return Text('Anúnicos',
                style: TextStyle(
                  color: AppColors.kSecondaryColorLight,
                ));
          return GestureDetector(
            child: LayoutBuilder(builder: (_, constraints) {
              return Container(
                width: constraints.biggest.width,
                child: Text(homeStore.search),
              );
            }),
            onTap: () => openSearch(context),
          );
        }),
        actions: [
          Observer(builder: (_) {
            if (homeStore.search.isEmpty)
              return IconButton(
                icon: Icon(
                  Icons.search,
                  color: AppColors.kSecondaryColor,
                ),
                onPressed: () {
                  openSearch(context);
                },
              );
            return IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                homeStore.setSearch('');
              },
            );
          }),
        ],
      ),
      body: Column(
        children: [
          TopBar(),
          Expanded(
            child: Observer(
              builder: (_) {
                if (homeStore.error != null)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 200,
                        color: AppColors.kPrimaryColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ocorreu um erro, ${homeStore.error}!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColors,
                        ),
                      ),
                    ],
                  );
                if (homeStore.showProgress)
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.kPrimaryColor),
                    ),
                  );
                if (homeStore.adList.isEmpty)
                  return EmptyCard('Nenhum anúncio encontrado');
                return ListView.builder(
                  itemCount: homeStore.itemCount,
                  itemBuilder: (_, index) {
                    if (index < homeStore.adList.length)
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 12, top: 4, right: 12),
                        child: AdTile(homeStore.adList[index]),
                      );

                    homeStore.loadNextPage();
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      height: 4,
                      child: LinearProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.kSecondaryColor),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
