import 'package:get/get.dart';
import '../view_model/firebase/firebase_services.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseServices(), fenix: true);
  }
}