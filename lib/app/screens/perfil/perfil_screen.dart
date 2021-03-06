import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/components/custom_drawer/custom_drawer.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/screens/favorites/favorites_screen.dart';
import 'package:works/app/screens/login/login_screen.dart';
import 'package:works/app/screens/my_ads/my_ads_screen.dart';
import 'package:works/app/screens/edit_account/edit_account.dart';
import 'package:works/app/stores/page_store.dart';
import 'package:works/app/stores/user_manager_store.dart';
import 'package:works/app/helpers/extensions.dart';

class PerfilScreen extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => EditAccount()));
            },
            child: Container(
              padding: EdgeInsets.only(right: 22),
              alignment: Alignment.center,
              child: Text(
                'EDITAR',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: AppColors.kPrimaryColor,
                    height: 60,
                  ),
                  SizedBox(height: 50),
                  Observer(builder: (_) {
                    return userManagerStore.user == null
                        ? CircularProgressIndicator()
                        : Text(
                            userManagerStore.user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: AppColors.titleColors,
                            ),
                          );
                  }),
                  SizedBox(height: 5),
                  Text(
                    userManagerStore.user.email,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Criado em ${userManagerStore.user.createdAt.formattedDate()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Column(
                  children: [
                    Divider(color: Colors.grey[500]),
                    ListTile(
                      title: Text(
                        'Meus An??ncios',
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.kPrimaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MyAdsScreen()),
                        );
                      },
                    ),
                    Divider(color: Colors.grey[500]),
                    ListTile(
                      title: Text(
                        'Favoritos',
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.kPrimaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FavoritesScreen(hideDrawer: true)));
                      },
                    ),
                    Divider(color: Colors.grey[500]),
                    ListTile(
                      title: Text(
                        'Sair',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        userManagerStore.logout();
                        GetIt.I<PageStore>().setPage(0);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                    ),
                    Divider(color: Colors.grey[500]),
                  ],
                ),
              )
            ],
          ),
          Observer(builder: (_) {
            return Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: AppColors.kSecondaryColor,
                maxRadius: 40,
                child: Text(
                  userManagerStore.user.name[0],
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
