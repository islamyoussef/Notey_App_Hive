import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notey/cubits/note_cubit.dart';
import '../../ihelper/local_vars.dart';
import '../../ihelper/shared_methods.dart';
import '../../models/note.dart';
import 'cust_note_card.dart';
import 'cust_text.dart';

class CustomNoteList extends StatelessWidget {
  CustomNoteList({super.key});

  SharedMethods sharedMethods = SharedMethods();
  final TextEditingController _txtTitle = TextEditingController();
  final TextEditingController _txtDetails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadingState) {
          // Loading state
          return Center(child: CircularProgressIndicator());
        } else if (state is NoteSuccessState) {
          // Succeeded state
          return ListView.builder(
            itemCount: state.listOfNotesLoaded.length,
            itemBuilder: (context, index) {
              return CustNoteCard(
                cardColor:
                    lVarListOfColors[state.listOfNotesLoaded[index].noteColor],
                title: state.listOfNotesLoaded[index].noteTitle,
                details: state.listOfNotesLoaded[index].noteDetails,
                cardDate: state.listOfNotesLoaded[index].noteDate.toString(),

                openModalSheet: () {
                  // Open modal sheet to update selected note
                  _txtTitle.text = state.listOfNotesLoaded[index].noteTitle;
                  _txtDetails.text = state.listOfNotesLoaded[index].noteDetails;
                  openModalBottomSheet(context, state.listOfNotesLoaded[index]);
                },
                onDeleteClick: () {
                  // Delete Note
                  context.read<NoteCubit>().deleteNote(
                    state.listOfNotesLoaded[index].noteID,
                  );

                },
              );
            },
          );
        } else {
          // Error happened while loading list of notes
          return Center(
            child: Text(
              'Error while loading notes',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> openModalBottomSheet(BuildContext ctx, Note selectedNote) async {
    return showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return BlocConsumer<NoteCubit, NoteState>(
          listener: (context, state) {
            // Your listener logic
            if (state is NoteSuccessState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Note was saved', style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),),backgroundColor:Colors.green,));
            } else if (state is NoteFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error I can\'t hold.',style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),),
                  backgroundColor: Colors.redAccent,),
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 16,
                right: 26,
                left: 26,
              ),
              child: Column(
                children: [
                  CustText(txtController: _txtTitle, txtHint: 'Insert title'),

                  CustText(
                    txtController: _txtDetails,
                    txtHint: 'Insert Details',
                    maxLine: 7,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Save note
                      // _formKey.currentState!.validate();
                      selectedNote.noteTitle = _txtTitle.text.trim();
                      selectedNote.noteDetails = _txtDetails.text.trim();
                      context.read<NoteCubit>().saveNote(selectedNote);
                      // Close Modal
                      //Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lVarListOfColors[selectedNote.noteColor],
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Save', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
