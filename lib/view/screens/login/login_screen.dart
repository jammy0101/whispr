import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/buttons/round_button.dart';
import '../../../core/buttons/round_button2.dart';
import '../../../core/constants/custom_text_field.dart';
import '../../../core/constants/custom_text_field_email.dart';
import '../../../core/routes/routes_name.dart';
import '../../../core/thems/colors/color.dart';
import '../../../view_model/firebase/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final FirebaseServices firebaseServices = Get.find<FirebaseServices>();

class _LoginScreenState extends State<LoginScreen> {
  final formKey2 = GlobalKey<FormState>();

  final TextEditingController emailControllerL = TextEditingController();
  final TextEditingController passwordControllerL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                'HELLO,WELCOME BACK',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: 5,),
              const Text(
                'Happy to see you again,to use your account please login first',
                style: TextStyle(fontSize: 19, color: Colors.grey),
              ),
              Form(
                key: formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                            image: ExactAssetImage('assets/images/DayFlowS.png')),
                      ],
                    ),
                    const Text(' Email Address'),
                    CustomTextFieldEmail(
                      controller: emailControllerL,
                      hintText: ''.tr,
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 8),
                    const Text('Password'),
                    Obx(() {
                      return CustomTextField(
                        controller: passwordControllerL,
                        obscureText: !firebaseServices.isPasswordVisibleL.value,
                        hintText: ''.tr,
                        suffixIcon: IconButton(
                          onPressed: firebaseServices.togglePasswordVisibilityL,
                          icon: Icon(
                            firebaseServices.isPasswordVisibleL.value
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        validator: validatePassword,
                      );
                    }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RoutesName.forgotPassword);
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Obx(() {
                return RoundButton(
                  width: double.infinity,
                  height: 55,
                  title: 'Login'.tr,
                  loading: firebaseServices.loadingLoginL.value,
                  onPress: () {
                    if (formKey2.currentState!.validate()) {
                      firebaseServices.login(
                        email: emailControllerL.text.trim(),
                        password: passwordControllerL.text.trim(),
                      );
                    }
                  },
                  roundButton: Colors.blueAccent,
                  textColor: AppColor.blackColor,
                );
              }),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              Obx(() {
                return RoundButton2(
                  width: 340,
                  height: 60,
                  loading: firebaseServices.loadingGoogleL.value,
                  title: '',
                  onPress: () async {
                    await firebaseServices.loginWithGoogle();
                  },
                  textColor: AppColor.blackColor,
                  buttonColor2: Colors.grey,
                  child: Image.asset(
                    'assets/images/googlelogo.png',
                    height: 45,
                  ),
                );
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?".tr),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesName.registrationScreen);
                    },
                    child: const Text(
                      ' Signup',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required".tr;
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email".tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required".tr;
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters".tr;
    }
    return null;
  }
}