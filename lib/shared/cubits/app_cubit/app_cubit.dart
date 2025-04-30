import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_it_sharks/models/user_model.dart';
import 'package:e_commerce_it_sharks/shared/network/remote/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../network/remote/dio_helper/dio_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());


  static AppCubit get(context)=>BlocProvider.of(context);
  UserModel? user;

  void getProfile(String token)async{
    emit(GetProfileLoading());

    try {
      Response response = await DioHelper.getData(
        endpoint: PROFILE,
        token: token,
      );
      user = UserModel.fromJson(response.data);
      if(user!.status!){
        emit(GetProfileSuccessfully());
      }
      else{
        emit(GetProfileWithError());
      }
    }catch(error){
      emit(GetProfileWithError());
    }
  }
}
