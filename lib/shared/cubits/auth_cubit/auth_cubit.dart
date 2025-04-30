import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_it_sharks/shared/network/remote/constants/constants.dart';
import 'package:e_commerce_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


static AuthCubit get(context)=> BlocProvider.of(context);
  void register({
    required String email,
    required String username,
    required String phoneNumber,
    required String password,
})async{
    emit(RegisterLoading());
    try {
      Response r = await DioHelper.postData(
          endpoint: REGISTER,
          body: {
            "name": username,
            "email": email,
            "password": password,
            "image": "",
            "phone": phoneNumber,
          }
      );
      if(r.data["status"]){
        print(r.data);
        emit(RegisterSuccessfully(r.data["data"]["token"]));
      }
      else{
        emit(RegisterWithError(r.data["message"]));
      }
    }catch(error){
      emit(RegisterWithError("Internal Server Error"));
    }

  }

  void login({
    required String email,

    required String password,
  })async{
    emit(LoginLoading());
    try {
      Response r = await DioHelper.postData(
          endpoint: LOGIN,
          body: {
            "email": email,
            "password": password,
          }
      );
      if(r.data["status"]){
        print(r.data);
        emit(LoginSuccessfully(r.data["data"]["token"]));
      }
      else{
        print(r.data);
        emit(LoginWithError(r.data["message"]));
      }
    }catch(error){
      emit(LoginWithError("Internal Server Error"));
    }

  }
}
