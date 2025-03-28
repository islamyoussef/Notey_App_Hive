import 'package:hive/hive.dart';
import '../models/note.dart';

class HiveHelper{

  static const String notesBoxName = 'HiveBox_Note';
  static late Box<Note> myBox;

  static Future<void> init() async{
    // This function to open the box
    myBox = await Hive.openBox<Note>(notesBoxName);
  }

  List<Note> listOfNotes = [];

  static List<Note> selectAllNotes() {
    return myBox.values.toList();
  }

  static Future<void> saveNote(Note note) async {
    if (note.noteID == -1) {
      // Getting a unique key and put it in noteID
      note.noteID =  DateTime.now().millisecondsSinceEpoch;
      await myBox.add(note);
    } else {
      // Update record by record index
      final index = myBox.values.toList().indexWhere((item) => item.noteID == note.noteID);
      await myBox.putAt(index, note);
    }
  }

  static Future<void> deleteNote(int noteID) async {
    // Getting record index by noteID
    final index = myBox.values.toList().indexWhere((item) => item.noteID == noteID);
    await myBox.deleteAt(index);
  }

}