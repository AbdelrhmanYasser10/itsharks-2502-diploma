part of 'counter_cubit.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

final class Increment extends CounterState {}
final class Decrement extends CounterState {}
