import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../thems/colors/color.dart';

class Utils {

  static void toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor:  AppColor.blackColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void snackBar(String title ,String message){
    Get.snackbar(
      title,
      message,
    );
  }

}