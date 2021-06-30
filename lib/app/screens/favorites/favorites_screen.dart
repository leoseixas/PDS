import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/components/custom_drawer/custom_drawer.dart';
import 'package:works/app/components/empty_card.dart';
import 'package:works/app/stores/favorite_store.dart';

import 'components/favorite_tile.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({this.hideDrawer = false});

  final bool hideDrawer;

  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      drawer: hideDrawer ? null : CustomDrawer(),
      body: Observer(builder: (_) {
        if (favoriteStore.favoriteList.isEmpty)
          return EmptyCard('Nenhum anúncio favoritado');
        return Container(
          child: ListView.builder(
            itemCount: favoriteStore.favoriteList.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.only(left: 12, top: 4, right: 12),
              child: FavoriteTile(favoriteStore.favoriteList[index]),
            ),
          ),
        );
      }),
    );
  }
}
