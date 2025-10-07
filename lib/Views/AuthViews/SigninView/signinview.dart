import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/AuthController/authcontroller.dart';
import 'package:student/Widgets/CustomButton/custombutton.dart';
import 'package:student/Widgets/CustomTextField/customtextfield.dart';
import 'package:student/Widgets/IsLoadind/isloading.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';
import 'package:student/Widgets/ToggleButton/togglebutton.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key});

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
                TextWidget.h1("Welcome back", AppColors.blackColor, context),
                SizedBox(height: 30),
                ToggleButton(),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget.h3(
                        "signin your account and continue \n your study",
                        AppColors.blackColor,
                        context,
                      ),
                      SizedBox(height: 35),
                      CustomTextField(
                        label: "Email Address",
                        controller: authController.emailController,
                        text: "Enter your email",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        label: "Password",
                        controller: authController.passwordController,
                        text: "Enter your password",
                        obsecure: true,
                        suffixicon: Icon(Icons.visibility_outlined),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: TextWidget.h3(
                              "Forgot Password?",
                              AppColors.purpleColor,
                              context,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 55),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              authController.signin();
                            },
                            child: authController.isLoading.value
                                ? Center(child: IsLoading())
                                : CustomButton(
                              text: "Signin",
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
