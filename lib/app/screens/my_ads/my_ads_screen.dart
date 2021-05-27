import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                  color: Colors.grey[700],
                  size: 100,
                ),
                const SizedBox(height: 8),
                Text(
                  'Ocorreu um erro, ${myAdsStore.error}!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            );
          if (myAdsStore.showProgress)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.grey[500]),
              ),
            );
          if (myAdsStore.myAdList.isEmpty)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.border_clear,
                    color: Colors.grey[700],
                    size: 100,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Você não possiu anúncios!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          return Padding(
            padding: EdgeInsets.only(top: 8),
            child: ListView.builder(
              itemCount: myAdsStore.myAdList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
