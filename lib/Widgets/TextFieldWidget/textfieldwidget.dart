import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student/Constants/AppColors/appcolors.dart';
import 'package:student/Widgets/TextWidget/textwidget.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? text;
  final Widget? suffixicon;
  final Widget? prefixicon;
  final bool obSecure;
  final bool readOnly;

  const TextFieldWidget({
    super.key,
    this.label,
    required this.controller,
    this.text,
    this.suffixicon,
    this.prefixicon,
    this.obSecure = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.h2(label??"", AppColors.blackColor, context),
        SizedBox(height: 8),
        TextField(
          readOnly: readOnly,
          controller: controller,
          obscureText: obSecure,
          style: GoogleFonts.poppins(
            color: AppColors.blackColor,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixicon,
            prefix: prefixicon,
            hintText: text,
            hintStyle: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w400,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.purpleColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.purpleColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.purpleColor),
            ),
          ),
        ),
      ],
    );
  }
}
