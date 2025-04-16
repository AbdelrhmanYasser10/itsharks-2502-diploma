import 'package:counter_state_management/screens/increment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/counter_cubit.dart';


class DecrementScreen extends StatelessWidget {
  const DecrementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        print("Iam in decrement screen and counter changed");
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
                      cubit.decrement();
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Go Back",
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
