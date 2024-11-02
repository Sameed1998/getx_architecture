import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/components/round_button.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view/login/widget/input_Text_widget.dart';
import 'package:getx_mvvm/view_models/controller/login/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginVM = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Login'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputTextWidget(
                    controller: loginVM.emailController.value,
                    focusNode: loginVM.emailFocusNode.value,
                    hintText: "email_hint".tr,
                    validatorMessage: "enter_email".tr,
                    onFieldSubmitted: (_) {
                      Utils.fieldFocusChange(
                        context,
                        loginVM.emailFocusNode.value,
                        loginVM.passwordFocusNode.value,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  InputTextWidget(
                    controller: loginVM.passwordController.value,
                    focusNode: loginVM.passwordFocusNode.value,
                    hintText: "password_hint".tr,
                    validatorMessage: "enter_password".tr,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  Obx(() => RoundButton(
                        title: 'Login'.tr,
                        width: width * .4,
                        loading: loginVM.loading.value,
                        onPress: _onLoginPressed,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      loginVM.loginApi();
    }
  }
}
