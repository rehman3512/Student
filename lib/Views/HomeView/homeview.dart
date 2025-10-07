import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Widgets/SubjectContainer/subjectcontainer.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';
import 'package:student/routes/approutes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(title: TextWidget.h2("HomeScreen", AppColors.whiteColor, context),
      backgroundColor: AppColors.purpleColor,),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget.h1("Subjects", AppColors.blackColor, context),
            SizedBox(height: 25,),
            Expanded(
              child: Obx((){
                if(studentController.subjectList.isEmpty){
                  return Center(child: Text("No subjects available"));
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8
                    ),
                    itemCount: studentController.subjectList.length,
                    itemBuilder: (context,index){
                      final subject = studentController.subjectList[index];
                      return SubjectContainer(
                        subject: subject,
                        onTap: (){
                        Get.toNamed(AppRoutes.subjectDetail,
                        arguments: subject);
                      },);
                    });
              }),
            ),
          ],
        ),
      ))
    );
  }
}
