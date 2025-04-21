part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

//* Get data from database states/
class GetDataLoading extends AppState {}
class GetDataSuccessfully extends AppState {}
class GetDataWithError extends AppState {}

//* Insert into database states/
class InsertNewNoteLoading extends AppState {}
class InsertNewNoteSuccessfully extends AppState {}
class InsertNewNoteWithError extends AppState {}

//* Delete from database states/
class DeleteNoteLoading extends AppState {}
class DeleteNoteSuccessfully extends AppState {}
class DeleteNoteWithError extends AppState {}

//* Insert into database states/
class UpdateLoading extends AppState {}
class UpdateSuccessfully extends AppState {}
class UpdateError extends AppState {}

//**/
class NoteisDoneSuccessully extends AppState{}
class NoteisDoneWithError extends AppState{}