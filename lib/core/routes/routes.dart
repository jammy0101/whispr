import 'package:get/get.dart';
import 'package:whispr/view/screens/splash/splash_screen2.dart';

import '../../bindings/auth_bindings.dart';
import '../../view/screens/addUser/addUser.dart';
import '../../view/screens/forgotpassword/forgotpassword.dart';
import '../../view/screens/home/home_screen.dart';
import '../../view/screens/login/login_screen.dart';
import '../../view/screens/registration/registration_screen.dart';
import '../../view/screens/setting/setting.dart';
import '../../view/screens/splash/splash_screen.dart';
import '../../view/widgets/emialSend/email_send.dart';
import '../../view/widgets/succesScreen/succes_screen.dart';
import 'routes_name.dart';


class AppRoutes {
  static List<GetPage> appRoutes() => [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.registrationScreen,
      page: () => RegistrationScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.splashScreen2,
      page: () => SplashScreen2(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.emailSentScreen,
      page: () => EmailSentScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.resetSuccessScreen,
      page: () => SuccessScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.addUser,
      page: () => Adduser(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.setting,
      page: () => Setting(),
      binding: AuthBinding(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
  ];
}
