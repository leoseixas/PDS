import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/stores/user_manager_store.dart';

class CustomDrawerHeader extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Works',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.kSecondaryColor,
                maxRadius: 20,
                child: Text(
                  userManagerStore.user.name[0],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userManagerStore.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                    Text(
                      userManagerStore.user.email,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
