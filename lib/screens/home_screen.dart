import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:database_itsharks/models/note_model.dart';
import 'package:database_itsharks/shared/cubits/app_cubit/app_cubit.dart';
import 'package:database_itsharks/shared/data/local/database_helper.dart';
import 'package:database_itsharks/shared/styles/colors/app_colors.dart';
import 'package:database_itsharks/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_new_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, Abdelrahman",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.kPrimaryColor,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D"),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "All Notes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    if (state is GetDataLoading) {
                      return LoadingWidget();
                    } else if (state is GetDataWithError) {
                      return const Center(
                        child: Text(
                          "Error while getting data",
                        ),
                      );
                    } else {
                      AppCubit cubit =
                      AppCubit.get(context); // instance material
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return buildNoteCard(
                            context,
                            note: cubit.allNotes[index],
                          );
                        },
                        itemCount: cubit.allNotes.length,
                        physics: const BouncingScrollPhysics(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddOrUpdateNoteScreen()));
        },
        backgroundColor: AppColors.kPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  GestureDetector buildNoteCard(BuildContext context,{required NoteModel note}) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (_)=> AddOrUpdateNoteScreen(note: note,))
        );
      },
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if(state is NoteisDoneWithError){
                    if(note.status == 1){
                      note.status = 0;
                    }
                    else{
                      note.status = 1;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            "Error while mark this note as done"
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  var cubit = AppCubit.get(context);
                  return Checkbox(
                    value: note.status == 1,
                    activeColor: AppColors.kPrimaryColor,
                    onChanged: (value) {
                      if (value!) {
                        note.status = 1;
                      }
                      else{
                        note.status = 0;
                      }
                      cubit.changeNoteStatus(note);

                    },
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title!,
                      style:  TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                          decorationThickness: 4,
                          decoration:note.status == 1?
                        TextDecoration.lineThrough:null
                      ),
                    ),
                    Text(
                      note.description!,
                      style:  TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                          decorationThickness: 4,
                          decoration:note.status == 1?
                          TextDecoration.lineThrough:null
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is DeleteNoteSuccessfully) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "This note deleted successfully"
                        ),
                      ),
                    );
                    AppCubit.get(context).getAllNotes();
                  }
                  if (state is DeleteNoteWithError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            "Error while deleting this note, try again later"
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  var cubit = AppCubit.get(context);
                  return GestureDetector(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.error,
                        body: const Center(child: Text(
                          'Are you sure you want to delete this note?',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),),
                        title: 'Delete Note',
                        desc: 'Delete Note',
                        btnOkOnPress: () {
                          cubit.deleteNote(note.id!);
                        },
                      ).show();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.kPrimaryColor,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
