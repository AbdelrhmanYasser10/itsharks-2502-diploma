import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubits/app_cubit/app_cubit.dart';
import '../shared/widgets/loading_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if(state is GetProfileLoading){
          return const LoadingWidget();
        }
        else if(state is GetProfileWithError){
          return const SizedBox();
        }
        return Scaffold(
          body: Center(
            child: Text(
                cubit.user!.data!.name!,
            ),
          ),
        );
      },
    );
  }
}
