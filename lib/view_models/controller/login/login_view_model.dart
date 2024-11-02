import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/models/login/user_model.dart';
import 'package:getx_mvvm/repository/login_repository/login_repository.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_models/controller/user_preference/user_preference_view_model.dart';

class LoginViewModel extends GetxController {
  final LoginRepository _api = LoginRepository();
  final UserPreference _userPreference = UserPreference();

  // Observable controllers and focus nodes
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  // Handles API login
  Future<void> loginApi() async {
    loading.value = true;

    final data = {
      'username': emailController.value.text.trim(),
      'password': passwordController.value.text.trim(),
    };

    try {
      final response = await _api.loginApi(data);
      _handleLoginResponse(response);
    } catch (e) {
      _handleError(e);
    } finally {
      loading.value = false;
    }
  }

  // Processes login response
  void _handleLoginResponse(Map<String, dynamic> response) {
    if (response['error'] == null) {
      _onLoginSuccess(response);
    } else {
      Utils.toastMessage(response['error']);
    }
  }

  // Actions on successful login
  Future<void> _onLoginSuccess(Map<String, dynamic> response) async {
    try {
      await _userPreference.saveUser(UserModel.fromJson(response));
      Get.toNamed(RoutesName.homeScreen);
      Get.delete<LoginViewModel>();
      Utils.toastMessage("login_successfully".tr);
    } catch (e) {
      if (kDebugMode) print("Error saving user: ${e.toString()}");
    }
  }

  // Handles errors during login
  void _handleError(dynamic error) {
    if (kDebugMode) print("Error in login: $error");
    Utils.toastMessage(error.toString());
  }
}
