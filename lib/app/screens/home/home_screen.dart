import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/custom_drawer/custom_drawer.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/home/components/search_dialog.dart';
import 'package:works/app/screens/home/components/top_bar.dart';
import 'package:works/app/stores/home_store.dart';

import 'components/ad_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();

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
    reaction((_) => homeStore.getListAds(), (adList) {
      if (adList == homeStore.adList) {
        return;
      } else {
        homeStore.adList.clear();
        homeStore.getListAds();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Observer(builder: (_) {
          if (homeStore.search.isEmpty) return Text('Anúnicos');
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
                icon: Icon(Icons.search),
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
          SizedBox(
            height: 4,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (homeStore.error != null)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.grey[700],
                        size: 100,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ocorreu um erro, ${homeStore.error}!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                if (homeStore.showProgress)
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.grey[400]),
                    ),
                  );
                if (homeStore.adList.isEmpty)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.border_clear,
                        color: Colors.grey[700],
                        size: 100,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nenhum anúncio encontrado!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                return ListView.builder(
                  itemCount: homeStore.itemCount,
                  itemBuilder: (_, index) {
                    if (index < homeStore.adList.length)
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
