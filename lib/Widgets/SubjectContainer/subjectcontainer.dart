import 'package:flutter/material.dart';
import 'package:student/Constants/AppAssets/appassets.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Models/SubjectModel/subjectmodel.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';

class SubjectContainer extends StatelessWidget {
  final SubjectModel subject;
  final VoidCallback onTap;
  SubjectContainer({super.key,required this.onTap,required this.subject});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.blackColor)
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(AppAssets.subjectLogo,),
              ),
              SizedBox(height: 15,),
              TextWidget.h2(subject.subject, AppColors.blackColor, context),
              SizedBox(height: 10,),
              Row(mainAxisSize: MainAxisSize.min,
                children: [
                TextWidget.h3(subject.duration, AppColors.blackColor, context),
                Spacer(),
                TextWidget.h3(subject.subjectId, AppColors.blackColor, context)
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
