import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/sources_model.dart';
import '../../network/remote/constants/constants.dart';
import '../../network/remote/dio_helper/dio_helper.dart';

part 'sources_state.dart';

class SourcesCubit extends Cubit<SourcesState> {
  SourcesCubit() : super(SourcesInitial());
  SourcesModel? allSources;

  static SourcesCubit get(context)=>BlocProvider.of(context);
  void getNewsSources()async{
    emit(GetSourcesDataLoading());
    try{
      Response result = await DioHelper.getData(
        endpoint: SOURCES,
        queryParams: {
          "country": "us",
          "apiKey": APIKEY,
        },
      );
      print(result.statusCode);
      print(result.data);
      if (result.statusCode == 200) {
        allSources = SourcesModel.fromJson(result.data);
        emit(GetSourcesDataSuccessfully());
      } else {
        emit(GetSourcesDataWithError(result.data["message"]));
      }
    }catch(err){
      emit(GetSourcesDataWithError("Unexpected error,try again later"));
    }
  }

}
