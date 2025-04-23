import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_it_sharks/model/news_model.dart';
import 'package:news_app_it_sharks/shared/network/remote/constants/constants.dart';
import 'package:news_app_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());


  static NewsCubit get(context)=>BlocProvider.of(context);

  NewsModel? homeNews;

  void getHomeData()async{
    emit(GetHomeDataLoading());
    try{
      Response result = await DioHelper.getData(
          endpoint: TOPHEALDINES,
          queryParams: {
            "country":"us",
            "apiKey":APIKEY,
          },
      );
      print(result.statusCode);
      print(result.data);
      if(result.statusCode == 200){
        homeNews = NewsModel.fromJson(result.data);
        emit(GetHomeDataSuccessfully());
      }
      else{
        emit(GetHomeDataWithError(result.data["message"]));

      }
    }catch(err){
      print(err.toString());
      emit(GetHomeDataWithError("Error while getting data"));
    }
  }

}
