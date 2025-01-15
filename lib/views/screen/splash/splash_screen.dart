import 'package:flutter/material.dart';
import 'package:gestion_app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../routes/routes.dart';
import '../../../utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    jump();
    super.initState();
  }

  jump() async {
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offAllNamed(AppRoutes.signIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Image.asset(AppImages.splashBgImage,
            width: double.infinity, fit: BoxFit.fill, height: double.infinity),
      ),
    );
  }
}
