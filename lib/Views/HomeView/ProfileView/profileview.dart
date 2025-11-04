// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:student/Constants/AppColors/appcolors.dart';
// import 'package:student/Controllers/AuthController/authcontroller.dart';
// import 'package:student/Controllers/StudentController/studentcontroller.dart';
// import 'package:student/Widgets/CustomButton/custombutton.dart';
// import 'package:student/Widgets/IsLoadind/isloading.dart';
// import 'package:student/Widgets/TextFieldOutline/TextFieldOutline.dart';
// import 'package:student/Widgets/TextWidget/textwidget.dart';
//
// class ProfileView extends StatelessWidget {
//   ProfileView({super.key});
//
//   final authController = Get.find<AuthController>();
//   final studentController = Get.find<StudentController>();
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero, () {
//       studentController.fetchProfile();
//     });
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.purpleColor,
//         title: TextWidget.h2("Student Profile", AppColors.whiteColor, context),
//       ),
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFieldOutline(
//                   prefixicon: Icon(Icons.person),
//                   label: "Name",
//                   controller: authController.userController,
//                   text: "Enter your name",
//                 ),
//                 SizedBox(height: 20),
//                 TextFieldOutline(
//                   prefixicon: Icon(Icons.email),
//                   label: "email",
//                   controller: authController.emailController,
//                   text: "Enter your email",
//
//                 ),
//                 SizedBox(height: 20),
//                 TextFieldOutline(
//                   prefixicon: Icon(Icons.cake),
//                   label: "age",
//                   controller: studentController.ageController,
//                   text: "Enter your age",
//                 ),
//                 SizedBox(height: 20),
//                 TextFieldOutline(
//                   prefixicon: Icon(Icons.male),
//                   label: "Gender",
//                   controller: studentController.genderController,
//                   text: "Enter your name",
//                 ),
//                 SizedBox(height: 50),
//                 Align(
//                   alignment: Alignment.center,
//                   child: GestureDetector(
//                     onTap: () {
//                       studentController.insertProfile();
//                     },
//                     child: studentController.isLoading.value
//                         ? Center(child: IsLoading())
//                         : CustomButton(
//                             text: "Save",
//                             textcolor: AppColors.whiteColor,
//                             color: AppColors.purpleColor,
//                           ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Align(
//                   alignment: Alignment.center,
//                   child: GestureDetector(
//                     onTap: () {
//                       studentController.deleteProfile();
//                     },
//                     child: studentController.isLoading.value
//                         ? IsLoading()
//                         : CustomButton(
//                             text: "Delete",
//                             textcolor: AppColors.whiteColor,
//                             color: AppColors.redColor,
//                           ),
//                   ),
//                 ),
//                 SizedBox(height: 30,),
//                 Align(
//                   alignment: Alignment.center,
//                   child: GestureDetector(
//                     onTap: () {
//                       authController.signout();
//                     },
//                     child: authController.isLoading.value
//                         ? IsLoading()
//                         : Container(
//                       height: MediaQuery.of(context).size.height * 0.06,
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200, // light background
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.logout, color: AppColors.redColor), // logout icon
//                           SizedBox(width: 8),
//                           Text(
//                             "Logout",
//                             style: TextStyle(
//                               color: AppColors.redColor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Controllers/AuthController/authcontroller.dart';
import 'package:student/Controllers/StudentController/studentcontroller.dart';
import 'package:student/Widgets/IsLoadind/isloading.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final authController = Get.find<AuthController>();
  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => studentController.fetchProfile());

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: SafeArea(
        child: Stack(
          children: [
            // Floating Orbs Background
            ..._buildFloatingOrbs(),

            // Main Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    _buildFloatingProfileCard(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Custom AppBar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildCustomAppBar(),
            ),
          ],
        ),
      ),
    );
  }

  // Floating Orbs (Pyara Background)
  List<Widget> _buildFloatingOrbs() {
    return [
      _orb(Offset(0.1, 0.2), 120, AppColors.glow.withOpacity(0.15)),
      _orb(Offset(0.8, 0.3), 180, AppColors.primary.withOpacity(0.1)),
      _orb(Offset(0.3, 0.7), 100, AppColors.accent.withOpacity(0.12)),
      _orb(Offset(0.9, 0.8), 140, AppColors.glow.withOpacity(0.1)),
    ];
  }

  Widget _orb(Offset center, double size, Color color) {
    return Positioned(
      left: Get.width * center.dx - size / 2,
      top: Get.height * center.dy - size / 2,
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 8 + (center.dx * 5).toInt()),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (_, value, __) {
          return Transform.translate(
            offset: Offset(0, 20 * (value - 0.5).abs()),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 40,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Custom AppBar
  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          _iconButton(Icons.arrow_back_ios_new_rounded, () => Get.back()),
          const Spacer(),
          Text(
            "My Profile",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // Floating 3D Card
  Widget _buildFloatingProfileCard(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 900),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.2 * (1 - value))
            ..scale(0.85 + (value * 0.15)),
          alignment: Alignment.center,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.glass,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.whiteColor.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(color: AppColors.shadow, blurRadius: 30, offset: const Offset(0, 15)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Column(
              children: [
                // 3D Avatar
                _build3DAvatar(),

                const SizedBox(height: 32),

                // Input Fields
                _cuteInput(Icons.person_rounded, "Full Name", authController.userController, "Ahmed Ali"),
                const SizedBox(height: 18),
                _cuteInput(Icons.email_rounded, "Email", authController.emailController, "ahmed@gmail.com", readOnly: true),
                const SizedBox(height: 18),
                _cuteInput(Icons.cake_rounded, "Age", studentController.ageController, "28"),
                const SizedBox(height: 18),
                _cuteInput(Icons.male, "Gender", studentController.genderController, "Male"),

                const SizedBox(height: 40),

                // Action Buttons
                Row(
                  children: [
                    Expanded(child: _cuteButton("Save", AppColors.primary, Icons.save_rounded, () => studentController.insertProfile())),
                    const SizedBox(width: 16),
                    Expanded(child: _cuteButton("Delete", AppColors.redColor, Icons.delete_forever_rounded, () => studentController.deleteProfile())),
                  ],
                ),

                const SizedBox(height: 24),

                // Logout
                Obx(() => authController.isLoading.value
                    ? const IsLoading()
                    : _cuteLogoutButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 3D Avatar with Glow
  Widget _build3DAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: AppColors.glow.withOpacity(0.6), blurRadius: 25, spreadRadius: 5),
            ],
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
          ),
          child: Icon(Icons.person_rounded, size: 60, color: AppColors.primary),
        ),
      ],
    );
  }

  // Cute Input with Floating Label
  Widget _cuteInput(IconData icon, String label, TextEditingController controller, String hint, {bool readOnly = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider, width: 1.5),
        boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.1), blurRadius: 8)],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: GoogleFonts.poppins(fontSize: 15, color: AppColors.blackColor, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.accent),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: AppColors.greyColor.withOpacity(0.6)),
          prefixIcon: Icon(icon, color: AppColors.accent, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  // Cute Button with Micro-Interaction
  Widget _cuteButton(String text, Color color, IconData icon, VoidCallback onTap) {
    return Obx(() {
      final isLoading = (text == "Save" && studentController.isLoading.value) ||
          (text == "Delete" && studentController.isDelete.value);
      return GestureDetector(
        onTap: isLoading ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.4), blurRadius: isLoading ? 0 : 12, offset: const Offset(0, 6)),
            ],
          ),
          child: isLoading
              ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.whiteColor))
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.whiteColor, size: 20),
              const SizedBox(width: 8),
              Text(text, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.whiteColor)),
            ],
          ),
        ),
      );
    });
  }

  // Cute Logout Button
  Widget _cuteLogoutButton() {
    return GestureDetector(
      onTap: () => authController.signout(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.redColor.withOpacity(0.5), width: 1.8),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.lightBg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: AppColors.redColor, size: 20),
            const SizedBox(width: 10),
            Text(
              "Logout",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.redColor),
            ),
          ],
        ),
      ),
    );
  }

  // Icon Button
  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.8),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}