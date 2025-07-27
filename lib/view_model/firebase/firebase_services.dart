import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/routes/routes_name.dart';

class FirebaseServices extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //:::::::>> LOADING FUNCTIONALITY <<:::::::::

  final loadingLoginL = false.obs;
  final loadingGoogleL = false.obs;
  final loadingRegistration = false.obs;
  RxBool loadingGoogleRegistration = false.obs;
  RxBool loading = false.obs;

  //:::::::::::>> password visibility section <<::::::::::::::

  //-------> For Registration <---------
  final isPasswordVisibleR = false.obs;
  final isPasswordVisibleRE = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisibleR.value = !isPasswordVisibleR.value;
  }

  void toggleConfirmPasswordVisibility() {
    isPasswordVisibleRE.value = !isPasswordVisibleRE.value;
  }

  //-------> For Login <---------
  final isPasswordVisibleL = false.obs;
  void togglePasswordVisibilityL() {
    isPasswordVisibleL.value = !isPasswordVisibleL.value;
  }

  //:::::::::::>> LOGIN, REGISTRATION and  GOOGLE FUNCTIONALITY<<::::::::::::

  Future<void> registration({
    required String email,
    required String password,
    required String fullName,
  }) async {
    loadingRegistration.value = true;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // ✅ Set the displayName explicitly
        await user.updateDisplayName(fullName);
        await user.reload(); // Important to reflect the change in currentUser
        final updatedUser = auth.currentUser;

        // ✅ Now save to Firestore
        await saveUserToFirestore(updatedUser!, fullName: fullName);
      }

      Get.snackbar("Successfully".tr, 'Registration Completed'.tr);
      print("User Register : ${userCredential.user!.uid}");
      Get.offAllNamed(RoutesName.homeScreen);
    } catch (e) {
      Get.snackbar('Error'.tr, e.toString());
      print("error : $e");
    } finally {
      loadingRegistration.value = false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    loadingLoginL.value = true;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar("Successfully".tr, 'Login Completed'.tr);
      print("User Login : ${userCredential.user!.uid}");
      Get.offAllNamed(RoutesName.homeScreen);
    } catch (e) {
      Get.snackbar('Error'.tr, e.toString());
      print("Error : $e");
    } finally {
      loadingLoginL.value = false;
    }
  }


  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      // Sign out first to always show account picker
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Cancelled'.tr, 'Google sign-in was cancelled'.tr);
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);

       final user = userCredential.user;
      if (user != null) {
        await saveUserToFirestore(user, fullName: user.displayName); // This is safe
      }
      Get.snackbar(
        'Welcome 👋',
        'Logged in as ${user?.displayName ?? 'User'}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
      );

      // ✅ Navigate to home screen
      Get.offAllNamed(RoutesName.homeScreen);

      return user;
    } catch (e) {
      Get.snackbar('Error'.tr, e.toString());
      return null;
    }
  }


  Future<void> saveUserToFirestore(User user, {String? fullName}) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot = await userRef.get();
    if (!snapshot.exists) {
      await userRef.set({
        'uid': user.uid,
        'name': fullName ?? user.displayName ?? '',
        'email': user.email ?? 'no email',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }



}