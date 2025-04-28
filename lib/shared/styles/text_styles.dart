import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppTextStyles{

  static TextStyle headlineTextStyle = GoogleFonts.quicksand(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle titleTextStyle = GoogleFonts.quicksand(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle subTitleTextStyle = GoogleFonts.quicksand(
    fontSize: 18.0,
    color: Colors.grey,
  );

  static TextStyle buttonTextStyle = GoogleFonts.quicksand(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w600
  );
  static TextStyle infoTextStyle = GoogleFonts.quicksand(
      fontSize: 12.0,
      color: Colors.black,
      fontWeight: FontWeight.w600
  );

  static TextStyle errorTextStyle = GoogleFonts.quicksand(
    fontSize: 18.0,
    color: AppColors.kErrorColor,

  );


}