part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class GetProfileLoading extends AppState {}
final class GetProfileSuccessfully extends AppState {}
final class GetProfileWithError extends AppState {}
