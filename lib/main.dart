import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_app/routes/routes.dart';
import 'package:gestion_app/themes/light_theme.dart';
import 'package:gestion_app/utils/app_constants.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: AppConstants.APP_NAME,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            theme: light(),
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
            getPages: AppRoutes.routes,
            initialRoute: AppRoutes.splashScreen,
          );
        });
  }
}
