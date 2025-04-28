import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';

class AuthenticationInfo extends StatelessWidget {
  final String hintText;
  final String buttonText;
  final VoidCallback buttonFunction;
  const AuthenticationInfo({
    super.key,
    required this.hintText,
    required this.buttonText,
    required this.buttonFunction
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
         hintText,
          style: AppTextStyles.infoTextStyle,
        ),
        const SizedBox(width: 5.0,),
        GestureDetector(
          onTap: buttonFunction,
          child: Text(buttonText,
            style: AppTextStyles.infoTextStyle.copyWith(
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
