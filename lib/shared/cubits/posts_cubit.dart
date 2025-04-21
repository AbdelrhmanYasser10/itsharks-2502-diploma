import 'package:api_posts_app_it_sharks/models/posts_model.dart';
import 'package:api_posts_app_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../network/remote/constants/constants.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  // PostsModel
  PostsModel? allPosts ;
  static PostsCubit get(context)=>BlocProvider.of(context);

  void getAllPosts()async{
    emit(PostsLoading());
    try {
      Response result = await DioHelper.getData(endpoint: POSTS);
      allPosts = PostsModel.fromJson(result.data);
      emit(PostsSuccess());
    }catch(err){
      emit(PostsError());
    }
  }



}
