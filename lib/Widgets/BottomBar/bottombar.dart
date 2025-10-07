import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Views/HomeView/EnrolledSubjects/enrolledsubjects.dart';
import 'package:student/Views/HomeView/FeeSubmit/feesubmit.dart';
import 'package:student/Views/HomeView/ProfileView/profileview.dart';
import 'package:student/Views/HomeView/homeview.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final studentController = StudentController();

  final List<Widget> screens = [
    HomeView(),
   EnrolledSubjects(),
    FeeSubmit(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        body: screens[studentController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: studentController.currentIndex.value,
            onTap: studentController.changeTab,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.purpleColor,
            unselectedItemColor: AppColors.greyColor,
            items: [BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: "Home",
            ),
              BottomNavigationBarItem(icon: Icon(Icons.school_outlined),
              label: "Enrolled"),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined),
              label: "Fees"),
              BottomNavigationBarItem(icon: Icon(Icons.person),
              label: "Profile"),
            ]),

      ),
    );
  }
}
