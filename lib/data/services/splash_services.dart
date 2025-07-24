// // import 'dart:async';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // import '../../core/routes/routes_name.dart';
// //
// // class SplashService {
// //   void isLogin(BuildContext context) async {
// //     final FirebaseAuth auth = FirebaseAuth.instance;
// //
// //     final User? user = auth.currentUser;
// //
// //     Timer(const Duration(seconds: 4), () {
// //       if (!isLanguageSelected) {
// //         Get.offAllNamed(RoutesName.splashScreen2);
// //       } else if (user != null) {
// //         Get.offAllNamed(RoutesName.homeScreen);
// //       } else {
// //         Get.offAllNamed(RoutesName.loginScreen);
// //       }
// //     });
// //   }
// // }
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../../core/routes/routes_name.dart';
//
//
// class SplashService {
//   void isLogin(BuildContext context) {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//
//     try {
//       final User? user = auth.currentUser;
//
//       Timer(const Duration(seconds: 2), () {
//         if (user != null) {
//           Get.offAllNamed(RoutesName.homeScreen);
//         } else {
//           Get.offAllNamed(RoutesName.loginScreen);
//         }
//       });
//     } catch (e) {
//       Get.snackbar("Error", "Authentication check failed: $e",
//           snackPosition: SnackPosition.BOTTOM);
//       Timer(const Duration(seconds: 4), () {
//         Get.offNamed(RoutesName.loginScreen);
//       });
//     }
//   }
// }
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../core/routes/routes_name.dart';
//
// class SplashService {
//   void isLogin(BuildContext context) {
//     Timer(const Duration(seconds: 2), () {
//       Get.offAllNamed(RoutesName.splashScreen2); // Move to "Get Started" screen
//     });
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/routes/routes_name.dart';

class SplashService {
  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding');
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    await Future.delayed(const Duration(seconds: 2)); // Wait

    if (hasSeenOnboarding == null || hasSeenOnboarding == false) {
      Get.offAllNamed(RoutesName.splashScreen2); // onboarding
    } else if (isLoggedIn) {
      Get.offAllNamed(RoutesName.homeScreen);
    } else {
      Get.offAllNamed(RoutesName.loginScreen);
    }
  }
}


