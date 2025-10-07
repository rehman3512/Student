import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Widgets/SubjectContainer/subjectcontainer.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';
import 'package:student/routes/approutes.dart';

class EnrolledSubjects extends StatelessWidget {
  EnrolledSubjects({super.key});

  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    // Fetch enrolled subjects when screen opens
    studentController.fetchEnrollments();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: TextWidget.h2("My Enrollments", AppColors.whiteColor, context),
        backgroundColor: AppColors.purpleColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget.h1("Enrolled Subjects", AppColors.blackColor, context),
              const SizedBox(height: 25),
              Expanded(
                child: Obx(() {
                  if (studentController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (studentController.subjectList.isEmpty) {
                    return const Center(
                      child: Text("No enrolled subjects found"),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: studentController.subjectList.length,
                    itemBuilder: (context, index) {
                      final subject = studentController.subjectList[index];

                      return SubjectContainer(
                        subject: subject,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.subjectDetail,
                            arguments: subject,
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
