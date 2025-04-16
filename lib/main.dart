import 'package:database_itsharks/shared/cubits/app_cubit/app_cubit.dart';
import 'package:database_itsharks/shared/data/local/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart';

void main() async {
  // Initialize Database
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.init();
  /* await DatabaseHelper.insert({
    "title":"Title 1",
    "desc":"Description 1",
    "date":DateTime.now().toString(),
    "status":0,
    "isFav":0,
  });
  await DatabaseHelper.insert({
    "title":"Title 2",
    "desc":"Description 2",
    "date":DateTime.now().toString(),
    "status":0,
    "isFav":0,
  });*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getAllNotes(), // Anonymous object
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}