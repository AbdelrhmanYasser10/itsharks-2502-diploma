import 'package:chat_app_itsharks_25/data_layer/authentication/user_repository/user_repo.dart';
import 'package:chat_app_itsharks_25/data_layer/authentication/user_web_service/user_web_service.dart';
import 'package:chat_app_itsharks_25/logic_layer/app_cubit/app_cubit.dart';
import 'package:chat_app_itsharks_25/logic_layer/auth_cubit/auth_cubit.dart';
import 'package:chat_app_itsharks_25/logic_layer/settings_cubit/settings_cubit.dart';
import 'package:chat_app_itsharks_25/presentation_layer/authentication/login/login_screen.dart';
import 'package:chat_app_itsharks_25/presentation_layer/layout/main_layout.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/styles/theme/app_theme.dart';
import 'package:chat_app_itsharks_25/presentation_layer/splash_screen/splash_screen.dart';
import 'package:chat_app_itsharks_25/services/cache_helper/cache_helper.dart';
import 'package:chat_app_itsharks_25/services/dio_helper/dio_helper.dart';
import 'package:chat_app_itsharks_25/services/notification_serivces/messaging_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

final navigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding:  WidgetsFlutterBinding.ensureInitialized());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesHelper.init();
  DioHelper.init();
  await MessagingConfiguration.configuration();
  FirebaseMessaging.onBackgroundMessage(MessagingConfiguration.messageHandler);
  /*await sendNotification(
    token:  MessagingConfiguration.getFCMToken()!,
    title: "Hello from the app",
    body: "This notification is sent from the application",
    data: {},

  );*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => SettingsCubit()..loadThemeFromCache()..loadLanguageCode()),
        BlocProvider(
          create: (context) => AppCubit(
            userRepo: UserRepository(
              UserWebService(),
            ),
          )..getUser(),
        ),
      ],
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SettingsCubit.get(context);
          return MaterialApp(
            title: cubit.languageCode == "en"?
            "Chat app" :"تطبيق الدردشة",
            navigatorKey: navigationKey,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: Locale(cubit.languageCode),
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home:const SplashScreen(),
          );
        },
      ),
    );
  }
}
