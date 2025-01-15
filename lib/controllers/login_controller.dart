import 'dart:convert';
import 'package:get/get.dart';
import '../../helpers/prefs_helper.dart';

import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../../utils/app_constants.dart';
import '../helpers/logger.dart';
import '../helpers/toast_message_helper.dart';
import '../routes/routes.dart';

class SignInController extends GetxController {
  ///=============== Log in ================
  final RxBool isObscure = true.obs;
  final RxBool logInLoading = false.obs;

  /// Toggle password visibility
  void toggleIsObscure() {
    isObscure.value = !isObscure.value;
  }

  /// Handle Log In
  Future<void> handleLogIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ToastMessageHelper.showToastMessage("Email and password cannot be empty.");
      return;
    }

    logInLoading(true);
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "email": email,
      "password": password,
    });

    try {
      var response = await ApiClient.postData(
        ApiConstants.signInEndPoint,
        body,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        "Status Code Is OK".logW();
        var data = response.body['data'];
        if (data != null) {
          try{
            await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']["accessToken"]);
            await PrefsHelper.setString(AppConstants.email, email);
            await PrefsHelper.setString(AppConstants.image, data['user']['image']);
            await PrefsHelper.setString(AppConstants.user, data['user']['_id']);
          }catch(e){
            e.toString().logE();
          }
          ToastMessageHelper.showToastMessage("Logged in successfully.");
          Get.offAllNamed(AppRoutes.calenderScreen);
        } else {
          ToastMessageHelper.showToastMessage("Failed to retrieve user data.");
        }
      } else {
        ToastMessageHelper.showToastMessage(response.body['message'] ?? "Login failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("An error occurred: $e");
    } finally {
      logInLoading(false);
    }
  }
}
