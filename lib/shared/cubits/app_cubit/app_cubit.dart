import 'package:bloc/bloc.dart';
import 'package:database_itsharks/models/note_model.dart';
import 'package:database_itsharks/shared/data/local/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=> BlocProvider.of(context); // object on materialApp
  // attribute to receive data
  List<NoteModel> allNotes = [];

  void getAllNotes()async{
    emit(GetDataLoading()); //loading
    try {
      allNotes = await DatabaseHelper.getAllData(); //7000
      emit(GetDataSuccessfully());
    }catch(error){
      emit(GetDataWithError());
    }
  }
}
