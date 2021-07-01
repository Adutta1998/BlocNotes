part of 'firestore_data_cubit.dart';

@immutable
abstract class FirestoreDataState {}

class FirestoreDataInitial extends FirestoreDataState {}
class FirestoreDataLoading extends FirestoreDataState{}
class FirestoreDeletedDataLoading extends FirestoreDataState{}
class FirestoreDataLoaded extends FirestoreDataState{
  final List<Note> notes;
  FirestoreDataLoaded(this.notes);
}

class FirestoreDataDeletedLoaded extends FirestoreDataState{
  final List<Note> notes;
  FirestoreDataDeletedLoaded(this.notes);
}

class FirestoreDataError extends FirestoreDataState{
}
