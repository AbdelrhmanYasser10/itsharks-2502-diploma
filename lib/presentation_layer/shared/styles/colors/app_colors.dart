import 'package:flutter/material.dart';

abstract class AppColors{


  //Primary Colors
  static const Color kPrimaryColor = Color(0xff005FFF);
  static const Color kOnlineColor = Color(0xff20E070);
  static const Color kDangerColor = Color(0xffFF3742);


  // light theme colors
  static const Color kBgLightColor = Color(0xfffcfcfc);
  static const Color kLightReceiverBackgroundMessageColor = Color(0xffffffff);
  static const Color kLightSenderBackgroundMessageColor = Color(0xffECEBEB);
  static const Color kLightSenderBackgroundMessageColorWithMedia = Color(0xffE9F2FF);



  // dark theme colors
  static const Color kBgDarkColor = Color(0xff13151B);
  static const Color kDarkReceiverBackgroundMessageColor = Color(0xff1C1E22);
  static const Color kDarkSenderBackgroundMessageColor = Color(0xff1C1E22);
  static const Color kDarkSenderBackgroundMessageColorWithMedia = Color(0xff00193D);


}