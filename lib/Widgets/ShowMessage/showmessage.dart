import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';

class ShowMessage{
  static successMessage(String message){
    Get.snackbar("Congratulations...!", message);
  }

  static errorMessage(String message){
    Get.snackbar("Error!!", message,
        backgroundColor: AppColors.redColor);
  }
}