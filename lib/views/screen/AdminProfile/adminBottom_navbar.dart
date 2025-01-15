import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/app_icons.dart';


class AdminBottomMenu extends StatelessWidget {
  final int menuIndex;

  const AdminBottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? Colors.white : theme.disabledColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
      label: title,
      icon: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SvgPicture.asset(
          image,
          height: 24.0,
          width: 24.0,
          color: colorByIndex(theme, index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(
        AppIcons.calenderIcon,
        'Calendar',
        theme,
        0,
      ),
      getItem(
        AppIcons.reserveIcon,
        'Reserve',
        theme,
        1,
      ),
      getItem(
        AppIcons.profileIcon,
        'Profile',
        theme,
        2,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.black,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          currentIndex: menuIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Get.offAndToNamed(AppRoutes.adminProfileScreen);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
