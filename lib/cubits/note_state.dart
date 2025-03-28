part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitialState extends NoteState {}

final class NoteLoadingState extends NoteState {}

final class NoteSuccessState extends NoteState {
  final  List<Note> listOfNotesLoaded;

  NoteSuccessState({required this.listOfNotesLoaded});
}

final class NoteFailedState extends NoteState {
  final String errorMessage;

  NoteFailedState({required this.errorMessage});
}