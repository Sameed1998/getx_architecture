import 'package:get/get.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/view/home/home_screen.dart';
import 'package:getx_mvvm/view/login/login_screen.dart';
import 'package:getx_mvvm/view/splash_screen.dart';

class AppRoutes{
  static appRoutes ()=>[
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250)
      ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250)
      ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250)
      ),
  ];
}