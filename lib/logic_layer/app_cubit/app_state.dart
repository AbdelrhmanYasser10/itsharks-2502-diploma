part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class GetUserDataLoading extends AppState {}
final class GetUserDataSuccessfully extends AppState {}
final class GetUserDataError extends AppState {}
