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
      allNotes = await DatabaseHelper.getAllData();
      allNotes = allNotes.reversed.toList();
      emit(GetDataSuccessfully());
    }catch(error){
      emit(GetDataWithError());
    }
  }


  void addNewNote({required String title , required String description})async{
    emit(InsertNewNoteLoading());
    try {
      NoteModel note = NoteModel(
        title: title,
        description: description,
        status: 0,
        isFav: 0,
        date: DateTime.now().toString(),
      );
      await DatabaseHelper.insert(note.toMap());
      emit(InsertNewNoteSuccessfully());
    }catch(error){
      emit(InsertNewNoteWithError());
    }
  }


  void deleteNote(int id)async{
    emit(DeleteNoteLoading());
    try{
      await DatabaseHelper.deleteNote(id);
      emit(DeleteNoteSuccessfully());
    }catch(error){
      emit(DeleteNoteWithError());
    }
  }

  void changeNoteStatus(NoteModel note)async{
    try {
      await DatabaseHelper.updateData(note);
      emit(NoteisDoneSuccessully());
    }catch(error){
      emit(NoteisDoneWithError());
    }
  }

  void updateNote(NoteModel note)async{
    emit(UpdateLoading());
    try {
      await DatabaseHelper.updateData(note);
      emit(UpdateSuccessfully());
    }catch(error){
      emit(UpdateError());
    }
  }

}
