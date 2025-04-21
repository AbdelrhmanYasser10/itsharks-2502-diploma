import 'package:database_itsharks/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelper{
  static Database? _database;
  static const _tableName="Note";


  static Future<void> init() async{
    if(_database == null) {
      var databasesPath = await getDatabasesPath(); //base
      var finalPath = "$databasesPath/note.db";
      _database = await openDatabase(
        finalPath,
        version: 1,
        onCreate: (HamadaHelal, version) async {
          print("Database Created");
          await HamadaHelal.execute(
              "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, date TEXT, status INTEGER, isFav INTEGER)"
          );
        },
        onOpen: (db) {
          print("Database Opened");
        },
      );
    }

  }

  //CRUD OPERATION
  // 1 - Create or insert
  static Future<void> insert(Map<String,dynamic> map) async{
    await _database!.insert(_tableName, map);
  }
  // 2 - Read Data
  static Future<List<NoteModel>> getAllData() async{
    List<Map<String,dynamic>> allData =  await _database!.query(_tableName); // data saved already in database

    List<NoteModel> allNotes = [];
     //Map<String,dynamic> ===> Note model object
    //List<NoteModel> allNotes = allData.map((element)=>NoteModel.fromMap(element)).toList();
    for(var element in allData){
      NoteModel note = NoteModel.fromMap(element);

      allNotes.add(note);
    }
    return allNotes;

  }

  // 3 - Update Data
  static Future<void> updateData(NoteModel note) async{
    await _database!.update(_tableName, note.toMap(),where: "id = ${note.id}");
  }

  // 4 - Delete Data
  static Future<void> deleteNote(int id) async{
    await _database!.delete(_tableName,where: "id = $id");
  }
}
