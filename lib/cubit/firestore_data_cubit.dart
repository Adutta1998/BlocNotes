import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:notes/Services/DatabaseService.dart';
import 'package:notes/Services/InternetService.dart';
import 'package:notes/data/Note.dart';
import 'package:notes/repository/FirebaseRepository.dart';

part 'firestore_data_state.dart';

class FirestoreDataCubit extends Cubit<FirestoreDataState> {
  FirebaseRepository repository;
  FirestoreDataCubit({required this.repository}) : super(FirestoreDataInitial());

  void fetchNotDeletedCollections() {
    emit(FirestoreDataLoading());
    InternetService().checkConnected().then((value)=>{
      if(value)
        repository.fetchNotDeletedCollections().then((notes)=>emit(FirestoreDataLoaded(notes)))
      else{
        print("finding cache"),
        DatabaseService.instance.fetchNotDeleted().then((value) => emit(FirestoreDataLoaded(value)))
      }
    });
  }

  void fetchDeletedCollections() {
    emit(FirestoreDeletedDataLoading());
    InternetService().checkConnected().then((value)=>{
      if(value)
        repository.fetchDeletedCollections().then((notes) => emit(FirestoreDataDeletedLoaded(notes)))
      else{
        print("finding cache"),
        DatabaseService.instance.fetchDeleted().then((value) => emit(FirestoreDataDeletedLoaded(value)))
      }
    });
  }
}
