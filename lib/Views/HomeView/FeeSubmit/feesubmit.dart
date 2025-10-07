import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Widgets/FeeForm/feeform.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';

class FeeSubmit extends StatelessWidget {
  FeeSubmit({super.key});

  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        title: TextWidget.h2("Fee Submit", AppColors.whiteColor, context),
      ),
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (studentController.subjectList.isNotEmpty) {
            // Yahan index 0 sirf example ke liye hai, jo subject pass karna hai use select kar lo
            Get.to(() => FeeForm(subject: studentController.subjectList[0]));
          } else {
            Get.snackbar(
              "Error",
              "No subject available",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
        child: Icon(Icons.add, color: AppColors.whiteColor),
        backgroundColor: AppColors.purpleColor,
      ),
      body: Center(
        child: TextWidget.h2("Fee Submit", AppColors.blackColor, context),
      ),
    );
  }
}
