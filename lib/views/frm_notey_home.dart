import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_notey/ihelper/local_vars.dart';
import 'package:my_notey/ihelper/shared_methods.dart';
import 'package:my_notey/views/custom_widgets/cust_appbar.dart';
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

class _FrmNoteyHomeState extends State<FrmNoteyHome> {

  final TextEditingController _txtTitle = TextEditingController();
  final TextEditingController _txtDetails = TextEditingController();
  final noteBox = Hive.box(lVarNotesBox);

  List<Note> listOfNotes = [];
  // [
  //   Note(noteID: '1', noteTitle: 'Note Title 1', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '2', noteTitle: 'Note Title 2', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '3', noteTitle: 'Note Title 3', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '4', noteTitle: 'Note Title 4', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '5', noteTitle: 'Note Title 5', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '6', noteTitle: 'Note Title 6', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '7', noteTitle: 'Note Title 7', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '8', noteTitle: 'Note Title 8', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '9', noteTitle: 'Note Title 9', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  //   Note(noteID: '10', noteTitle: 'Note Title 10', noteDetails: 'Animating an Opacity widget directly causes the widget ', noteDate: DateTime.now(), noteColor: SharedMethods.getRandomColor()),
  // ];

  Future<void> _saveNote(Map<String, dynamic> note) async{
    if(note['noteID'] == -1)
    {
      await noteBox.add(note);
    }else {
      await noteBox.put(note['noteID'], note);
    }
  }

  Future<void> _deleteNote(int noteID) async{
    await noteBox.delete(noteID);
    _selectNotes();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note has been deleted.'),));
  }

  void _selectNotes(){
    final allNotes = noteBox.keys.map((key){
      final noteData = noteBox.get(key);
      return {
        //noteID, noteTitle, noteDetails, noteDate,noteColor
        "noteID":key,
        "noteTitle": noteData["noteTitle"],
        "noteDetails": noteData["noteDetails"],
        "noteDate": noteData["noteDate"],
        "noteColor": noteData["noteColor"],
      };
    }).toList();

    setState(() {
      listOfNotes.clear();
      var listOfNotesMap = allNotes.reversed.cast<Map<String, dynamic>>().toList() ;
      for(var item in listOfNotesMap ){
        listOfNotes.add(Note(noteID: item['noteID'], noteTitle: item['noteTitle'], noteDetails: item['noteDetails'], noteDate: item['noteDate'], noteColor: item['noteColor']));
      }
    });

    log(listOfNotes.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectNotes();
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
          CustAppBar(title: 'Notes App',icon: Icons.search_rounded,onClick: (){}),

          Expanded(
            child: ListView.builder(
              itemCount: listOfNotes.length,
              itemBuilder: (context, index) {
                return CustNoteCard(
                  cardColor: lVarListOfColors[listOfNotes[index].noteColor],
                  title: listOfNotes[index].noteTitle,
                  details: listOfNotes[index].noteDetails,
                  cardDate: listOfNotes[index].noteDate.toString(),
                  openModalSheet: (){
                    _txtTitle.text = listOfNotes[index].noteTitle;
                    _txtDetails.text = listOfNotes[index].noteDetails;
                    openModalBottomSheet(listOfNotes[index]);
                  },
                  onDeleteClick: (){
                    _deleteNote(listOfNotes[index].noteID);
                },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _txtTitle.text = '';
          _txtDetails.text = '';
          openModalBottomSheet(Note(
              noteID: -1,
              noteTitle: 'Insert Title',
              noteDetails: 'Insert Details',
              noteDate: DateTime.now(),
              noteColor:SharedMethods.getRandomColor() ));
          },
        backgroundColor: lVarMainColor,
        foregroundColor: Colors.black,
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future openModalBottomSheet(Note selectedNote){
    return showModalBottomSheet(
      context: context,
      builder: (context)
      {
        return Container(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16,
            right: 26,
            left: 26,
          ),
          child: Column(
            children: [
              CustText(
                  txtController: _txtTitle,
                  txtHint: 'Insert title'
              ) ,

              CustText(
                txtController: _txtDetails,
                txtHint: 'Insert Details',
                maxLine: 7,
              ),

              ElevatedButton(
                onPressed:() {

                 Map<String, dynamic> noteData = {
                   //noteID
                   'noteID':selectedNote.noteID,
                   'noteTitle': _txtTitle.text.trim(),
                   'noteDetails': _txtDetails.text.trim(),
                   'noteDate': DateTime.now(),
                   'noteColor': selectedNote.noteColor
                 };

                  _saveNote(noteData);
                  //print(noteData['noteID']);

                  // Refresh
                  _selectNotes();

                  // Close Modal
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lVarListOfColors[selectedNote.noteColor],
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );

      },
    );
  }

}
