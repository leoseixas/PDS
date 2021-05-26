import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/helpers/extensions.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/screens/create_ad/create_ad_screen.dart';
import 'package:works/app/stores/my_ads_store.dart';

class MyAdTile extends StatelessWidget {
  MyAdTile(this.ad, this.myAdsStore);

  final Ad ad;
  final MyAdsStore myAdsStore;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Deletar', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 4),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      ad.images.isEmpty
                          ? 'https://static.thenounproject.com/png/194055-200.png'
                          : ad.images.first,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ad.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.titleColors,
                      ),
                    ),
                    Text(
                      ad.price.formattedMoney(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.titleColors,
                      ),
                    ),
                    Text(
                      '${ad.createdDate.formattedDate()} - '
                      '${ad.address.city.name} - '
                      '${ad.address.uf.initials}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleColors,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                onSelected: (choice) {
                  switch (choice.index) {
                    case 0:
                      editAd(context);
                      break;
                    case 1:
                      deleteAd(context);
                      break;
                  }
                },
                itemBuilder: (_) {
                  return choices
                      .map((choice) => PopupMenuItem<MenuChoice>(
                            value: choice,
                            child: Row(
                              children: [
                                Icon(
                                  choice.iconData,
                                  size: 20,
                                  color: AppColors.kSecondaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  choice.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kSecondaryColor),
                                ),
                              ],
                            ),
                          ))
                      .toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => CreateAdScreen(ad: ad)));
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluído'),
        content: Text('Confirmar a exclusão de \'${ad.title}\'?'),
        actions: <Widget>[
          TextButton(
            child: Text('Não'),
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              primary: Colors.green,
            ),
          ),
          TextButton(
            child: Text('Sim'),
            onPressed: () async {
              myAdsStore.deleteAd(ad);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
