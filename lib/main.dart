import 'package:api_posts_app_it_sharks/screens/home_screen.dart';
import 'package:api_posts_app_it_sharks/shared/cubits/posts_cubit.dart';
import 'package:api_posts_app_it_sharks/shared/network/remote/constants/constants.dart';
import 'package:api_posts_app_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// DRIBBLE ==> UI/UX


void main() {
  DioHelper.init();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getAllPosts(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
