import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/AuthController/authcontroller.dart';
import 'package:student/Widgets/CustomButton/custombutton.dart';
import 'package:student/Widgets/CustomTextField/customtextfield.dart';
import 'package:student/Widgets/IsLoadind/isloading.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';
import 'package:student/Widgets/ToggleButton/togglebutton.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget.h1("Welcome", AppColors.blackColor, context),
                SizedBox(height: 30),
                ToggleButton(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget.h3(
                        "Create your account and learn \n with us",
                        AppColors.blackColor,
                        context,
                      ),
                      SizedBox(height: 35),
                      CustomTextField(
                        label: "UserName",
                        controller: authController.userController,
                        text: "Enter your username",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        label: "Email Address",
                        controller: authController.emailController,
                        text: "Enter you email",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        label: "Password",
                        controller: authController.passwordController,
                        text: "Enter your password",
                        obsecure: true,
                        suffixicon: Icon(Icons.visibility_off_outlined),
                      ),
                      SizedBox(height: 55),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              authController.signup();
                            },
                            child: authController.isLoading.value
                                ? Center(child: IsLoading())
                                : CustomButton(
                              text: "Signup",
                              textcolor: AppColors.whiteColor,
                              color: AppColors.purpleColor,
                            ),
                          ),
                        ],
                      ),
                    ],
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
