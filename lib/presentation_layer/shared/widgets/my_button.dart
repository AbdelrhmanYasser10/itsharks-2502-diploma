import 'package:chat_app_itsharks_25/logic_layer/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/colors/app_colors.dart';
import '../styles/text_styles/text_styles.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? bgColor;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
     this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: AppTextStyles.font18WhiteBold.copyWith(
              color:(cubit.isDark && bgColor == null) ? AppColors.kPrimaryColor : Colors.white,
            ),
          ),
        );
      },
    );
  }
}