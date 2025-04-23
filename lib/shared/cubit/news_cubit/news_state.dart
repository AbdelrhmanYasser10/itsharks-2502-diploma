part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class GetHomeDataLoading extends NewsState {}
final class GetHomeDataSuccessfully extends NewsState {}
final class GetHomeDataWithError extends NewsState {
  final String message;
  GetHomeDataWithError(this.message);
}
