import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/AuthController/authcontroller.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Models/SubjectModel/subjectmodel.dart';
import 'package:student/Widgets/CustomButton/custombutton.dart';
import 'package:student/Widgets/IsLoadind/isloading.dart';
import 'package:student/Widgets/TextFieldWidget/textfieldwidget.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';

class FeeForm extends StatelessWidget {
  final SubjectModel subject;
  FeeForm({super.key,required this.subject});

  final authController = Get.find<AuthController>();
  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,)
        ),
        title: TextWidget.h2("Fee Form", AppColors.whiteColor, context),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                  label: "Student Name",
                  controller: authController.userController,
                  text: "Enter your Name",
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  label: "Father Name",
                  controller: studentController.fatherNameController,
                  text: "Enter your father name",
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  label: "Subject Id",
                  controller: studentController.subjectIdController,
                  text: "Enter Subject Id",
                ),
                SizedBox(height: 20),TextFieldWidget(
                  label: "Account Holder",
                  controller: studentController.accountHolderController,
                  text: "Enter account holder name",
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  label: "Track Id",
                  controller: studentController.trackIdController,
                  text: "Enter transaction track Id",
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  label: "Transaction Method",
                  controller: studentController.transactionController,
                  text: "Enter transaction method",
                ),
                SizedBox(height: 40),
                Obx(
                      ()=> GestureDetector(
                    onTap: () {
                      studentController.submitFee(subject);
                    },
                    child: studentController.isLoading.value
                        ? Center(child: IsLoading())
                        : Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: "Submit",
                        textcolor: AppColors.whiteColor,
                        color: AppColors.purpleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
