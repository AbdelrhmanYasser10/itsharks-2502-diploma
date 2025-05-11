import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles/colors/app_colors.dart';

class MyTextFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String?Function(String?) validator;
  final bool isPassword;
  const MyTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    required this.validator,
    this.isPassword = false,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool isSecure;
  final FocusNode _focusNode = FocusNode();
  bool _isFoucs = false;
  @override
  void initState() {
    super.initState();
    isSecure = widget.isPassword;
    _focusNode.addListener((){
      setState(() {
        print(_focusNode.hasFocus);
        _isFoucs = _focusNode.hasFocus;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      obscureText: isSecure,
      controller: widget.controller,
      cursorColor: AppColors.kPrimaryColor,
      validator: widget.validator,
      decoration:InputDecoration(
        suffixIcon: widget.isPassword ? IconButton(
            onPressed: (){
              setState(() {
                isSecure = !isSecure;
              });
            },
            icon: Icon(
              isSecure ? FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,
              color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,

            ),
        ):null,
          filled: true,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,
          ),
          fillColor: Colors.white,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              )
          ) ,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.kDangerColor,
              )
          ) ,
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.kPrimaryColor,
              )
          ) ,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              )
          )
      ),
    );
  }

/*  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
    _focusNode.removeListener((){});
    _focusNode.dispose();
  }*/
}
