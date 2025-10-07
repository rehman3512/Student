import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Models/SubjectModel/subjectmodel.dart';
import 'package:student/Widgets/CustomButton/custombutton.dart';
import 'package:student/Widgets/TextFieldWidget/textfieldwidget.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';
import 'package:student/routes/approutes.dart';

class SubjectDetail extends StatelessWidget {
  final SubjectModel subject;
  SubjectDetail({super.key}) : subject = Get.arguments;

  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    studentController.subjectController.text = subject.subject;
    studentController.subjectIdController.text = subject.subjectId;
    studentController.durationController.text = subject.duration;
    studentController.registrationController.text = subject.registration;
    studentController.teacherController.text = subject.teacher;
    studentController.classController.text = subject.classTime;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.whiteColor,
          ),
        ),
        title: TextWidget.h2(subject.subject, AppColors.whiteColor, context),
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
                  readOnly: true,
                ),
                SizedBox(height: 12),
                TextFieldWidget(
                  label: "Subject Id",
                  controller: studentController.subjectIdController,
                  readOnly: true,
                ),
                SizedBox(height: 12),
                TextFieldWidget(
                  label: "Duration",
                  controller: studentController.durationController,
                  readOnly: true,
                ),
                SizedBox(height: 12),
                TextFieldWidget(
                  label: "Registration Fees",
                  controller: studentController.registrationController,
                  readOnly: true,
                ),
                SizedBox(height: 12),
                TextFieldWidget(
                  label: "Teacher",
                  controller: studentController.teacherController,
                  readOnly: true,
                ),
                SizedBox(height: 12),
                TextFieldWidget(
                  label: "Class",
                  controller: studentController.classController,
                  readOnly: true,
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.enrollForm,
                      arguments: subject);
                    },
                    child: CustomButton(
                      text: "Enroll",
                      textcolor: AppColors.whiteColor,
                      color: AppColors.purpleColor,
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
