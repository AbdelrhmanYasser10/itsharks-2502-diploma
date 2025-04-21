import 'package:database_itsharks/shared/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onClick;
  final TextStyle? textStyle;
  const CustomButton({
    super.key ,
    required this.buttonText,
  required this.onClick ,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return             ElevatedButton(

      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        minimumSize: const Size(double.infinity,55.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),

      child: Text(
        buttonText,
        style: textStyle ?? GoogleFonts.inter(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
