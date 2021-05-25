import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/ad.dart';

class BottomBar extends StatelessWidget {
  BottomBar(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final phone =
                          '55${ad.user.phone.replaceAll(RegExp('[^0-9]'), '')}';
                      print(phone);
                      final link = WhatsAppUnilink(
                        phoneNumber: '$phone',
                        text:
                            "Olá, gostaria de falar sobre seu anúncio na Works - ${ad.title}",
                      );
                      await launch('$link');
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.whatsAppColors,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/whatsapp.png',
                            width: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Whatsapp',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final phone =
                          ad.user.phone.replaceAll(RegExp('[^0-9]'), '');
                      launch('tel:$phone');
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.callColors,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/phone.png',
                            width: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Ligar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFEEF4F6),
              border: Border(
                top: BorderSide(color: Colors.grey[400]),
              ),
            ),
            height: 30,
            alignment: Alignment.center,
            child: Text(
              '${ad.user.name} (Anunciante)',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
