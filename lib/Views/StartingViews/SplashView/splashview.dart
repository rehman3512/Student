import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Controllers/AuthController/authcontroller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
