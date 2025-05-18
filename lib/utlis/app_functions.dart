import 'package:flutter/material.dart';

void navigateToReplacement(BuildContext context, Widget screen){
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}