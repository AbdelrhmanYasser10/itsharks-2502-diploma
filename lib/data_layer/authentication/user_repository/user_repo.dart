import 'package:chat_app_itsharks_25/data_layer/authentication/model/user_model.dart';
import 'package:chat_app_itsharks_25/data_layer/authentication/user_web_service/user_web_service.dart';

class UserRepository{
  final UserWebService userWebService;

  UserRepository(this.userWebService);


  Future<UserModel> getUserModelFromWebService()async{
    return UserModel.fromJson(await userWebService.getUserFromFirebase());
  }



}