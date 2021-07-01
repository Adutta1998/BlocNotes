import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:notes/data/Note.dart';
import 'package:notes/repository/FirebaseRepository.dart';

part 'firestore_data_state.dart';

class FirestoreDataCubit extends Cubit<FirestoreDataState> {
  FirebaseRepository repository;
  FirestoreDataCubit({required this.repository}) : super(FirestoreDataInitial());

  void fetchNotDeletedCollections() {
    emit(FirestoreDataLoading());
    repository.fetchNotDeletedCollections().then((notes)=>emit(FirestoreDataLoaded(notes)));
  }

  void fetchDeletedCollections() {
    emit(FirestoreDeletedDataLoading());
    repository.fetchDeletedCollections().then((notes) => emit(FirestoreDataDeletedLoaded(notes)));
  }
}
