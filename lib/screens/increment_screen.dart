import 'package:counter_state_management/cubits/counter_cubit.dart';
import 'package:counter_state_management/screens/decrement_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncrementScreen extends StatelessWidget {
  const IncrementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        print("Iam in increment screen and the counter changed");
      },
      builder: (context, state) {
        var cubit = CounterCubit.get(context);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Counter value = ${cubit.counter}",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cubit.increment();
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const DecrementScreen()));
                  },
                  child: const Text(
                    "Go To Screen 2",
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
