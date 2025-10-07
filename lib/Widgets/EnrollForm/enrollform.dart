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

class EnrollForm extends StatelessWidget {
  final SubjectModel subject;
  EnrollForm({super.key}) : subject = Get.arguments;

  final authController = Get.find<AuthController>();
  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    studentController.subjectController.text = subject.subject;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.whiteColor,
          ),
        ),
        title: TextWidget.h2("Enroll Form", AppColors.whiteColor, context),
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
                  label: "Subject",
                  controller: studentController.subjectController,
                  text: "Enter your subject",
                  readOnly: true,
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  label: "student Name",
                  controller: authController.userController,
                  text: "Enter your name",
                ),
                SizedBox(height: 20),
                TextFieldWidget(
                  label: "Father Name",
                  controller: studentController.fatherNameController,
                  text: "Enter your father name",
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
                      studentController.submitEnroll(subject);
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
