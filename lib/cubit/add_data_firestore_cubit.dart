import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repository/FirebaseRepository.dart';

part 'add_data_firestore_state.dart';

class AddDataFirestoreCubit extends Cubit<AddDataFirestoreState> {
  FirebaseRepository repository;
  AddDataFirestoreCubit({required this.repository}) : super(AddDataFirestoreInitial());

  void addData(String title, String note) {
    emit(AddDataFirestoreAdding());
    repository.addData(title,note).then((value) => emit(AddDataFirestoreAdded(status: value)));
  }

  void setCheckStateChange(bool checkState){
    emit(AddDataFirestoreVideoState(checkState));
  }
}
