import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_it_sharks/layout/main_layout.dart';
import 'package:news_app_it_sharks/shared/cubit/news_cubit/news_cubit.dart';
import 'package:news_app_it_sharks/shared/cubit/sources_cubit/sources_cubit.dart';
import 'package:news_app_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';

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
        create: (context) => NewsCubit()..getHomeData(),
        ),
      BlocProvider(
        create: (context) => SourcesCubit()..getNewsSources(),
      ),
    ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Application',
        home: MainLayout(),
      ),
    );
  }
}
