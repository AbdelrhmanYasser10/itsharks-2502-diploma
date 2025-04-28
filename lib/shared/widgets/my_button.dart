import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.buttonTextStyle,
      ),
    );
  }
}
