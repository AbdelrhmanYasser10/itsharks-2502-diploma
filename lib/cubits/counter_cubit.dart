import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
static CounterCubit get(context)=>BlocProvider.of(context);
  int counter = 0;

  void increment() {
    counter++;
    emit(Increment());
  }
  void decrement(){
    counter--;
    emit(Decrement());
  }
}
