// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get title {
    return Intl.message('Hello', name: 'title', desc: '', args: []);
  }

  /// `Login`
  String get login_txt {
    return Intl.message('Login', name: 'login_txt', desc: '', args: []);
  }

  /// `login to chat with your friends`
  String get login_subtitle {
    return Intl.message(
      'login to chat with your friends',
      name: 'login_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password_hint {
    return Intl.message('Password', name: 'password_hint', desc: '', args: []);
  }

  /// `OR`
  String get or_txt {
    return Intl.message('OR', name: 'or_txt', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dont_have_acc {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_acc',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup_txt {
    return Intl.message('Signup', name: 'signup_txt', desc: '', args: []);
  }

  /// `Username`
  String get username_txt {
    return Intl.message('Username', name: 'username_txt', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password_txt {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password_txt',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register_txt {
    return Intl.message('Register', name: 'register_txt', desc: '', args: []);
  }

  /// `register to chat with your friends`
  String get register_sub_txt {
    return Intl.message(
      'register to chat with your friends',
      name: 'register_sub_txt',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery_txt {
    return Intl.message('Gallery', name: 'gallery_txt', desc: '', args: []);
  }

  /// `Camera`
  String get camera_txt {
    return Intl.message('Camera', name: 'camera_txt', desc: '', args: []);
  }

  /// `Already have an account?`
  String get already_have_acc_txt {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_acc_txt',
      desc: '',
      args: [],
    );
  }

  /// `Enter your message ....`
  String get enter_message_txt {
    return Intl.message(
      'Enter your message ....',
      name: 'enter_message_txt',
      desc: '',
      args: [],
    );
  }

  /// `Sending Error`
  String get sending_err_txt {
    return Intl.message(
      'Sending Error',
      name: 'sending_err_txt',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection`
  String get check_internet_conn_txt {
    return Intl.message(
      'Check your internet connection',
      name: 'check_internet_conn_txt',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chat_txt {
    return Intl.message('Chats', name: 'chat_txt', desc: '', args: []);
  }

  /// `Profile`
  String get profile_txt {
    return Intl.message('Profile', name: 'profile_txt', desc: '', args: []);
  }

  /// `Settings`
  String get settings_txt {
    return Intl.message('Settings', name: 'settings_txt', desc: '', args: []);
  }

  /// `Dark Theme`
  String get dark_theme_txt {
    return Intl.message(
      'Dark Theme',
      name: 'dark_theme_txt',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_txt {
    return Intl.message('Language', name: 'language_txt', desc: '', args: []);
  }

  /// `Options`
  String get options_txt {
    return Intl.message('Options', name: 'options_txt', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile_txt {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile_txt',
      desc: '',
      args: [],
    );
  }

  /// `Chat App`
  String get chat_app_txt {
    return Intl.message('Chat App', name: 'chat_app_txt', desc: '', args: []);
  }

  /// `Log Out`
  String get logout_txt {
    return Intl.message('Log Out', name: 'logout_txt', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
