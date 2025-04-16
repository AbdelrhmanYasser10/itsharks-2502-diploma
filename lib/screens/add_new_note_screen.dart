import 'package:database_itsharks/shared/cubits/app_cubit/app_cubit.dart';
import 'package:database_itsharks/shared/data/local/database_helper.dart';
import 'package:flutter/material.dart';

class AddNewNoteScreen extends StatelessWidget {
  const AddNewNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await DatabaseHelper.insert({
                "title": "Title 3",
                "desc": "Description 3",
                "date": DateTime.now().toString(),
                "isFav": 0,
                "status": 0,
              });
              AppCubit.get(context).getAllNotes();
            },
            child: Text("Add Note")),
      ),
    );
  }
}
