import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyErrorWidget extends StatelessWidget {
  final String animationPath;
  final String message;
  final VoidCallback reloadMethod;
  const MyErrorWidget({
    super.key,
    required this.animationPath,
    required this.message,
    required this.reloadMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animationPath,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            message,
            style:const TextStyle(
              fontSize:18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: reloadMethod,
            child: const Text(
              "Reload",
              style: TextStyle(
                fontSize:18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
