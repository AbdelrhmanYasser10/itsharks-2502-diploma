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
                child: BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {
                    // Logic
                    print(state);
                  },
                  builder: (context, state) {
                    if (state is GetDataLoading) {
                      return LoadingWidget();
                    } else if (state is GetDataWithError) {
                      return Center(
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
                            note: cubit.allNotes[index],
                          );
                        },
                        itemCount: cubit.allNotes.length,
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
              context, MaterialPageRoute(builder: (_) => AddNewNoteScreen()));
        },
        backgroundColor: AppColors.kPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Card buildNoteCard({required NoteModel note}) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Checkbox(
              value: note.status == 1,
              activeColor: AppColors.kPrimaryColor,
              onChanged: (value) async {
                if (value!) {
                  DatabaseHelper.updateData(note).then((value) {});
                } else {
                  DatabaseHelper.updateData(note).then((value) {}); //bg
                }
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    note.description!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.kPrimaryColor,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
