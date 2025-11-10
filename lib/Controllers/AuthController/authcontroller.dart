import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:student/Widgets/ForgotDialog/forgotDialog.dart';
import 'package:student/Widgets/ShowMessage/showmessage.dart';
import 'package:student/routes/approutes.dart';
import 'dart:async';


class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLogin = false.obs;
  var isForgot = false.obs;
  final RxBool isPasswordHidden = true.obs;


  var resendSeconds = 30.obs;
  var canResend = false.obs;
  Timer? timer;

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signin() async {
    try {
      isLoading.value = true;

      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ShowMessage.errorMessage("Error: All fields are required");
      } else if (!GetUtils.isEmail(emailController.text)) {
        ShowMessage.errorMessage("Error: Enter a valid email address");
      } else if (passwordController.text.length < 6) {
        ShowMessage.errorMessage(
          "Error: Password must be at least 6 characters",
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        User? user = FirebaseAuth.instance.currentUser;

        if (!user!.emailVerified) {
          await user.sendEmailVerification();
          ShowMessage.successMessage(
            "Email Verification send check your email",
          );
        } else {
          ShowMessage.successMessage("Your successfully Logged in");
          clearFields();
          Get.offAndToNamed(AppRoutes.bottomBar);
        }
      }
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  signup() async {
    try {
      isLoading.value = true;

      if (userController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        ShowMessage.errorMessage("Error: All fields are required");
      } else if (!GetUtils.isEmail(emailController.text)) {
        ShowMessage.errorMessage("Error: Enter a valid email address");
      } else if (passwordController.text.length < 6) {
        ShowMessage.errorMessage(
          "Error: Password must be at least 6 characters",
        );
      } else {
        // ✅ Create user in Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text,
            );

        User? user = userCredential.user;

        if (user != null) {
          // ✅ Save user details in Firestore
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({
                "userId": user.uid,
                "userEmail": user.email,
                "userName": userController.text.trim(),
                "userFatherName": "",
                "userAge": "",
                "userGender": "",
                "emailVerified": user.emailVerified, // save initial status
                "createdAt": FieldValue.serverTimestamp(),
              });

          // ✅ Send verification email if not verified
          if (!user.emailVerified) {
            await user.sendEmailVerification();
            ShowMessage.successMessage(
              "Verification email sent to ${user.email}",
            );
          }
        }

        ShowMessage.successMessage("Your account successfully created");
        clearFields();
        Get.offAndToNamed(AppRoutes.signinScreen);
      }
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  signout() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.signOut();
      ShowMessage.successMessage("Your successfully logout");
      Get.offAndToNamed(AppRoutes.signupScreen);
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLogin();
  }

  checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAndToNamed(AppRoutes.bottomBar);
    } else {
      Get.offAndToNamed(AppRoutes.signupScreen);
    }
  }

  clearFields() {
    userController.clear();
    emailController.clear();
    passwordController.clear();
  }


  ForgotPassword() async {
    try {
      isForgot.value = true;

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      startResendTimer(); // Start timer when email is sent

      Get.dialog(
        ForgotPasswordDialog(),
        barrierDismissible: false,
      );
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    } finally {
      isForgot.value = false;
    }
  }


  resendPasswordEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ShowMessage.successMessage("Password reset email resent successfully!");
      startResendTimer(); // restart timer
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    }
  }


  void startResendTimer() {
    resendSeconds.value = 30;
    canResend.value = false;
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }



}
