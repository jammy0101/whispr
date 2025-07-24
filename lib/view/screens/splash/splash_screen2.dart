import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whispr/core/thems/colors/color.dart';
import '../../../core/buttons/round_button.dart';
import '../../../core/routes/routes_name.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  // void handleGetStarted() {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User? user = auth.currentUser;
  //
  //   if (user != null) {
  //     Get.offAllNamed(RoutesName.homeScreen); // Already logged in
  //   } else {
  //     Get.offAllNamed(RoutesName.loginScreen); // Not logged in
  //   }
  // }

  void handleGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true); // Mark as seen

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      Get.offAllNamed(RoutesName.homeScreen); // Already logged in
    } else {
      Get.offAllNamed(RoutesName.loginScreen); // Not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Get Closer to EveryOne", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Help you to contact everyOne with just easy way", style: TextStyle(fontSize: 20)),
            ),
            Image(
              height: 450,
                image: ExactAssetImage('assets/images/DayFlow.png')),
            const SizedBox(height: 20),
            RoundButton(
                height: 50,
                width: 240,
                title: 'Get Started',
                onPress: handleGetStarted,
                roundButton: AppColor.blueColor,
                textColor: AppColor.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
