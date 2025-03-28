import 'package:hive/hive.dart';

// This code to make this model a hive Object
part 'note.g.dart'; /* then write this command in terminal (flutter packages pub run build_runner build) */
@HiveType(typeId: 0)
class Note extends HiveObject{

  // noteID, noteTitle, noteDetails, noteDate,noteColor
  @HiveField(0)
  int noteID;

  @HiveField(1)
  String noteTitle;

  @HiveField(2)
  String noteDetails;

  @HiveField(3)
  DateTime noteDate;

  @HiveField(4)
  int noteColor;

  Note({required this.noteID,required this.noteTitle,required this.noteDetails,required this.noteDate,required this.noteColor});
}