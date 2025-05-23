import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';

import '../authentication/login/login_screen.dart';
import '../layout/main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    print("In splash screeeeeeeeeeeeeeeeeeeeeeeeeen");
    FlutterNativeSplash.remove();
    controller = AnimationController(vsync: this);
    controller.addListener(() {
      print("Listen on changes");
      Widget goToScreen = FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const MainLayout();
      if (controller.isCompleted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => goToScreen,
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Lottie.asset(
            "assets/images/Animation - 1748017247756.json",
            controller: controller,
           onLoaded: (p0) {
             controller
               ..duration = p0.duration
               ..forward();
           },
          ),
        ),
      ),
    );
  }
}
