import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/components/empty_card.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/stores/my_ads_store.dart';
import 'package:works/app/screens/my_ads/components/my_ad_tile.dart';

class MyAdsScreen extends StatelessWidget {
  final MyAdsStore myAdsStore = MyAdsStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anúncios'),
      ),
      body: Container(
        child: Observer(builder: (_) {
          if (myAdsStore.error != null)
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
                  'Ocorreu um erro, ${myAdsStore.error}!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColors,
                  ),
                ),
              ],
            );
          if (myAdsStore.showProgress)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  AppColors.kPrimaryColor,
                ),
              ),
            );
          if (myAdsStore.myAdList.isEmpty)
            return EmptyCard('Nenhum anúncio favoritado');
          return Container(
            child: ListView.builder(
              itemCount: myAdsStore.myAdList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4, right: 12),
                  child: MyAdTile(myAdsStore.myAdList[index], myAdsStore),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
