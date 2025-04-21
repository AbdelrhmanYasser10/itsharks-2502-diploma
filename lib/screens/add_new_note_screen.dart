import 'package:database_itsharks/models/note_model.dart';
import 'package:database_itsharks/shared/cubits/app_cubit/app_cubit.dart';
import 'package:database_itsharks/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/widgets/custom_text_field.dart';
import '../shared/widgets/custom_button.dart';


class AddOrUpdateNoteScreen extends StatefulWidget {
  final NoteModel? note;
  const AddOrUpdateNoteScreen({super.key,this.note});

  @override
  State<AddOrUpdateNoteScreen> createState() => _AddOrUpdateNoteScreenState();
}

class _AddOrUpdateNoteScreenState extends State<AddOrUpdateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String title ="";
  @override
  void initState() {
    super.initState();
    if(widget.note == null){
      title = "Add new note";
    }
    else{
      title = "Edit Note";
      _titleController.text = widget.note!.title!;
      _descriptionController.text = widget.note!.description!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _titleController,
              title: "Title",
              icon: Icons.title,
              hintText: "Enter Your title",
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomTextField(
              controller: _descriptionController,
              title: "Description",
              icon: Icons.subject,
              hintText: "Enter Your Description",
              isDescription: true,
            ),
            /*SizedBox(
              height: MediaQuery.of(context).size.height * 0.52,
            ),*/
            const Spacer(),
            BlocConsumer<AppCubit, AppState>(
              // LOGIC
              listener: (context, state) {
                if(state is InsertNewNoteSuccessfully || state is UpdateSuccessfully){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          "Note added successfully"
                      ),
                    ),
                  );
                  AppCubit.get(context).getAllNotes();
                  Navigator.pop(context);
                }
                if(state is InsertNewNoteWithError || state is UpdateError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Error while adding this note, try again later"
                      ),
                    ),
                  );
                }
              },
              // UI
              builder: (context, state) {
                if(state is InsertNewNoteLoading || state is UpdateLoading){
                  return const LoadingWidget();
                }
                return CustomButton(
                  onClick: () {
                    if (_titleController.text.isEmpty &&
                        _descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              "Make sure you enter a title and a description"
                          ),
                        ),
                      );
                    }
                    else {
                      if(widget.note == null) {
                        AppCubit.get(context).addNewNote(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                      }else{
                        widget.note!.title = _titleController.text;
                        widget.note!.description = _descriptionController.text;
                        AppCubit.get(context).updateNote(widget.note!);
                      }
                    }
                  },
                  buttonText: title,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
