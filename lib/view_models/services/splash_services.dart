import 'dart:async';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/view_models/controller/user_preference/user_preference_view_model.dart';


class SplashServices {
  final UserPreference userPreference = UserPreference();

  Future<void> isLogin() async {
    final myUser = await userPreference.getUser();

    Timer(const Duration(seconds: 3), () {
      if (myUser != null) {
        Get.offNamed(RoutesName.homeScreen); // Replace current screen with home
      } else {
        Get.offNamed(RoutesName.loginScreen); // Replace current screen with login
      }
    });
  }
}