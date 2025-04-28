import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';

class MyTextFormField extends StatefulWidget {
  final String labelText;
  final String?Function(String?) validatorFunction;
  final TextEditingController controller;
  final IconData icon;

  const MyTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validatorFunction,
    required this.icon,
  });


  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(
      () {
        setState((){
          isFocused = _focusNode.hasFocus;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validatorFunction,
      focusNode: _focusNode,

      cursorColor: AppColors.kPrimaryColor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppTextStyles.subTitleTextStyle.copyWith(
          color:  isFocused ? AppColors.kPrimaryColor : Colors.grey,
        ),
        prefixIcon:  Icon(
          widget.icon,
          color: isFocused ? AppColors.kPrimaryColor : Colors.grey,
        ),
        border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            )
        ),
        focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.kPrimaryColor,
            )
        ),
        errorBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.kErrorColor,
            )
        ),
        errorStyle: AppTextStyles.errorTextStyle,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Performance
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    widget.controller.dispose();
  }
}
