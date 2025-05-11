import 'package:bloc/bloc.dart';
import 'package:chat_app_itsharks_25/data_layer/authentication/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/authentication/user_repository/user_repo.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final UserRepository userRepo;
  AppCubit({
    required  this.userRepo,
}) : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);

  UserModel? user;

  void getUser()async{
    emit(GetUserDataLoading());
    try {
      user = await userRepo.getUserModelFromWebService();
      emit(GetUserDataSuccessfully());
    }catch(error){
      emit(GetUserDataError());
    }
  }
}
