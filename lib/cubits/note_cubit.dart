import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_notey/ihelper/hive_helper.dart';
import '../models/note.dart';

part 'note_state.dart';
class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitialState());

  // Incase of scuceeded we need a list of modal class to return
  static List<Note> listOfNotes = [];

  // Return all notes
  void getAllNotes(){
    emit(NoteLoadingState());
    try {
      listOfNotes = HiveHelper.selectAllNotes();
      emit(NoteSuccessState(listOfNotesLoaded: listOfNotes));
    }catch(ex){
      emit(NoteFailedState(errorMessage: ex.toString()));
    }
  }

  // Save note
  Future<void> saveNote(Note note) async{
    emit(NoteLoadingState());
    try {
      await HiveHelper.saveNote(note);
      getAllNotes();
    }catch(ex){
      emit(NoteFailedState(errorMessage: ex.toString()));
    }
  }

  // Delete note
  Future<void> deleteNote(int noteID) async{
    emit(NoteLoadingState());
    try {
      await HiveHelper.deleteNote(noteID);
      getAllNotes();
    }catch(ex){
      emit(NoteFailedState(errorMessage: ex.toString()));
    }
  }

}
