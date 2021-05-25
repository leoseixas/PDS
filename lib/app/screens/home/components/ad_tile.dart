import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';
import 'package:works/app/helpers/extensions.dart';
import 'package:works/app/screens/ad/ad_screen.dart';

class AdTile extends StatelessWidget {
  AdTile(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdScreen(ad)));
      },
      child: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Row(
              children: [
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
                Container(
                  margin: EdgeInsets.only(left: 10),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
