import 'package:e_commerce_it_sharks/screen/register_screen.dart';
import 'package:e_commerce_it_sharks/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_it_sharks/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterScreen(),
      ),
    );
  }
}
