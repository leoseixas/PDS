import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/screens/ad/components/main_panel.dart';
import 'package:works/app/screens/ad/components/description_panel.dart';
import 'package:works/app/stores/user_manager_store.dart';
import 'package:works/app/stores/favorite_store.dart';

import 'components/bottom_bar.dart';
import 'components/location_panel.dart';
import 'components/user_panel.dart';

class AdScreen extends StatelessWidget {
  AdScreen(this.ad);

  final Ad ad;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.kSecondaryColorLight),
        title: Text(
          'Anúncio',
          style: TextStyle(color: AppColors.kSecondaryColorLight),
        ),
        actions: [
          if (ad.user.id != userManagerStore.user.id)
            Observer(builder: (_) {
              return IconButton(
                  icon: Icon(
                      favoriteStore.favoriteList.any((a) => a.id == ad.id)
                          ? Icons.favorite
                          : Icons.favorite_border),
                  onPressed: () => favoriteStore.toggleFavorite(ad));
            }),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: ad.images
                      .map((url) => CachedNetworkImageProvider(url))
                      .toList(),
                  dotSize: 3,
                  dotBgColor: Colors.transparent,
                  dotColor: AppColors.kSecondaryColor,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    MainPanel(ad),
                    Divider(color: Colors.grey[500]),
                    DescriptionPanel(ad),
                    Divider(color: Colors.grey[500]),
                    LocationPanel(ad),
                    Divider(color: Colors.grey[500]),
                    UserPanel(ad),
                    if (userManagerStore.user.id == ad.user.id)
                      Container()
                    else if (ad.user.phone == null)
                      SizedBox(height: 30)
                    else
                      SizedBox(height: 84),
                  ],
                ),
              )
            ],
          ),
          if (userManagerStore.user.id == ad.user.id)
            Container()
          else
            BottomBar(ad),
        ],
      ),
    );
  }
}
