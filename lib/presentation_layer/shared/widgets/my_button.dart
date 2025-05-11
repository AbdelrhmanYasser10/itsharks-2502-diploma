import 'package:flutter/material.dart';

import '../styles/text_styles/text_styles.dart';

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
      onPressed: onPressed,
      child: Text(
        text,
        style:AppTextStyles.font18WhiteBold,
      ),
    );
  }
}