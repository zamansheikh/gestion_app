import 'package:gestion_app/views/screen/AdminProfile/adminProfile_screen.dart';
import 'package:gestion_app/views/screen/AdminProfile/newClientCreate_screen.dart';
import 'package:gestion_app/views/screen/AdminProfile/userList_screen.dart';
import 'package:gestion_app/views/screen/auth/login/login_screen.dart';
import 'package:gestion_app/views/screen/calendar/calendar_screen.dart';
import 'package:gestion_app/views/screen/profile/change_password.dart';
import 'package:gestion_app/views/screen/profile/personal_information.dart';
import 'package:gestion_app/views/screen/profile/privacyPolicy_screen.dart';
import 'package:gestion_app/views/screen/profile/profile_screen.dart';
import 'package:gestion_app/views/screen/profile/settings_screen.dart';
import 'package:gestion_app/views/screen/profile/terms_services.dart';
import 'package:gestion_app/views/screen/reservation/reservation_detail_screen.dart';
import 'package:gestion_app/views/screen/reservation/reservation_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/screen/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String signIn = "/SignIn.dart";
  static const String reservationsScreen = "/ReservationsScreen.dart";
  static const String revervationDetailScreen = "/RevervationDetailScreen.dart";
  static const String calenderScreen = "/CalenderScreen.dart";
  static const String profileScreen = "/ProfileScreen.dart";
  static const String personalInformation = "/PersonalInformation.dart";
  static const String settingsScreen = "/SettingsScreen.dart";
  static const String changePassword = "/ChangePassword.dart";
  static const String privacyPolicyScreen = "/privacyPolicyScreen.dart";
  static const String termsServicesScreen = "/TermsServicesScreen.dart";
  static const String adminProfileScreen = "/AdminProfileScreen.dart";
  static const String newClientCreateScreen = "/NewClientCreateScreen.dart";
  static const String userListScreen = "/UserListScreen.dart";




  static List<GetPage> get routes => [
    GetPage(name: splashScreen, page: () =>  SplashScreen()),
    GetPage(name: signIn, page: () =>  SignInScreen()),
    GetPage(name: reservationsScreen, page: () =>  ReservationsScreen()),
    GetPage(name: revervationDetailScreen, page: () =>  RevervationDetailScreen()),
    GetPage(name: calenderScreen, page: () =>  CalenderScreen()),
    GetPage(name: profileScreen, page: () =>  ProfileScreen()),
    GetPage(name: personalInformation, page: () =>  PersonalInformationScreen()),
    GetPage(name: settingsScreen, page: () =>  SettingsScreen()),
    GetPage(name: changePassword, page: () =>  ChangePasswordScreen()),
    GetPage(name: privacyPolicyScreen, page: () =>  PrivacyPolicyScreen()),
    GetPage(name: termsServicesScreen, page: () =>  TermsServicesScreen()),
    GetPage(name: adminProfileScreen, page: () =>  AdminProfileScreen()),
    GetPage(name: newClientCreateScreen, page: () =>  NewClientCreateScreen()),
    GetPage(name: userListScreen, page: () =>  UserListScreen()),



  ];
}