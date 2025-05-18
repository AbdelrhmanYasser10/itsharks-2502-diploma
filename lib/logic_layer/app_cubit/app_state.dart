part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class GetUserDataLoading extends AppState {}
final class GetUserDataSuccessfully extends AppState {}
final class GetUserDataError extends AppState {}

final class UserDataChanged extends AppState {}


final class GetAllUserDataLoading extends AppState {}
final class GetAllUserDataSuccessfully extends AppState {}
final class GetAllUserDataError extends AppState {}


final class SendingMessageLoading extends AppState{}
final class SendingMessageSuccessfully extends AppState{}

final class GetAllMessagesLoading extends AppState{}
final class GetAllMessagesSuccesfully extends AppState{}
final class GetAllMessagesError extends AppState{}



final class UploadImageLoading extends AppState{}
final class UploadImageSuccessfully extends AppState{}
final class UploadImageError extends AppState{}


final class GetImageSuccessfully extends AppState{}
final class GetImageError extends AppState{}
final class CropImageSuccessfully extends AppState{}
final class CropImageError extends AppState{}
final class ClearImage extends AppState{}
