part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

//* Get data from database states/
class GetDataLoading extends AppState {}
class GetDataSuccessfully extends AppState {}
class GetDataWithError extends AppState {}
