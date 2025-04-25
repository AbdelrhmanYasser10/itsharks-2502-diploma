import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_it_sharks/model/news_model.dart';
import 'package:news_app_it_sharks/model/sources_model.dart';
import 'package:news_app_it_sharks/shared/network/remote/constants/constants.dart';
import 'package:news_app_it_sharks/shared/network/remote/dio_helper/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  NewsModel? homeNews;
  NewsModel? resultsNews;

  void getHomeData() async {
    emit(GetHomeDataLoading());
    try {
      Response result = await DioHelper.getData(
        endpoint: TOPHEALDINES,
        queryParams: {
          "country": "us",
          "apiKey": APIKEY,
        },
      );
      print(result.statusCode);
      print(result.data);
      if (result.statusCode == 200) {
        homeNews = NewsModel.fromJson(result.data);
        emit(GetHomeDataSuccessfully());
      } else {
        emit(GetHomeDataWithError(result.data["message"]));
      }
    } catch (err) {
      print(err.toString());
      emit(GetHomeDataWithError("Error while getting data"));
    }
  }

  void getResultsNews({required String key , int filter = 0}) async {
    emit(GetResultsLoading());
    try {
      late Response result;
      if(filter == 0) {
        result =
        await DioHelper.getData(endpoint: TOPHEALDINES, queryParams: {
          "country": "us",
          "apiKey": APIKEY,
          "category": key,
        });
      }else if(filter == 1){
        result =
        await DioHelper.getData(endpoint: EVERYTHING, queryParams: {
          //"country": "us",
          "apiKey": APIKEY,
          "q": key,
        });
      }
      else{
        result =
        await DioHelper.getData(endpoint: EVERYTHING, queryParams: {
          //"country": "us",
          "apiKey": APIKEY,
          "sources": key,
        });
      }
      if(result.statusCode == 200){
        resultsNews = NewsModel.fromJson(result.data);
        emit(GetResultsSuccessfully());
      }
      else{
        emit(GetResultsWithError(result.data["message"]));
      }
    } catch (err) {
      emit(GetResultsWithError("Error while getting data"));
    }
  }


}
