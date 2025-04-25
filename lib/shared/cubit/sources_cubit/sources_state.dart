part of 'sources_cubit.dart';

@immutable
sealed class SourcesState {}

final class SourcesInitial extends SourcesState {}
final class GetSourcesDataLoading extends SourcesState {}

final class GetSourcesDataSuccessfully extends SourcesState {}

final class GetSourcesDataWithError extends SourcesState {
final String message;
GetSourcesDataWithError(this.message);
}
