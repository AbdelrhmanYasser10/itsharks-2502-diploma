import 'package:database_itsharks/shared/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final bool isDescription;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.title,
    required this.controller,
    this.isDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          minLines: isDescription ? 3 : 1,
          maxLines: isDescription ? 5 : 1,
          cursorColor: AppColors.kPrimaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: isDescription
                ? null
                : Icon(
                    icon,
                  ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.kPrimaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
