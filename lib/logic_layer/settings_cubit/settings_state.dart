part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class LoadThemeFromCache extends SettingsState {}
final class LoadLanguageFromCache extends SettingsState {}
final class ChangeTheme extends SettingsState {}
final class ChangeLanguage extends SettingsState {}
