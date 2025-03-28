import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_notey/cubits/note_cubit.dart';
import 'package:my_notey/ihelper/hive_helper.dart';
import 'package:my_notey/ihelper/local_vars.dart';
import 'package:my_notey/ihelper/shared_methods.dart';
import 'package:my_notey/views/custom_widgets/cust_appbar.dart';
import 'package:my_notey/views/custom_widgets/cust_note_list.dart';
import 'package:my_notey/views/custom_widgets/cust_text.dart';
import '../models/note.dart';
import 'custom_widgets/cust_note_card.dart';

class FrmNoteyHome extends StatefulWidget {
  const FrmNoteyHome({super.key});

  @override
  State<FrmNoteyHome> createState() => _FrmNoteyHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Set the preferred size
}

//final _formKey = GlobalKey<FormState>();

class _FrmNoteyHomeState extends State<FrmNoteyHome> {

  final TextEditingController _txtTitle = TextEditingController();
  final TextEditingController _txtDetails = TextEditingController();

  SharedMethods sharedMethods = SharedMethods();
  List<Note> listOfNotes = NoteCubit.listOfNotes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _txtTitle.dispose();
    _txtDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // →→→→→→→→→→→→→ Appbar
          CustAppBar(
            title: 'Notes App',
            icon: Icons.search_rounded,
            onClick: () {},
          ),

          // →→→→→→→→→→→→→ List of cards
          Expanded(child: CustomNoteList()),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _txtTitle.text = '';
          _txtDetails.text = '';
          openModalBottomSheet(
            Note(
              noteID: -1,
              noteTitle: 'Insert Title',
              noteDetails: 'Insert Details',
              noteDate: DateTime.now(),
              noteColor: SharedMethods.getRandomColor(),
            ),
          );
        },
        backgroundColor: lVarMainColor,
        foregroundColor: Colors.black,
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> openModalBottomSheet(Note selectedNote) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocConsumer<NoteCubit, NoteState>(
          listener: (context, state) {
            // Your listener logic
            if(state is NoteSuccessState)
            {

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note saved',style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),),backgroundColor: Colors.green,),);

            }else if(state is NoteFailedState){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error I can't hold")),);
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(top: 16, bottom: 16, right: 26, left: 26),
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
                      selectedNote.noteTitle = _txtTitle.text.trim();
                      selectedNote.noteDetails = _txtDetails.text.trim();
                      selectedNote.noteDate = DateTime.now();

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
