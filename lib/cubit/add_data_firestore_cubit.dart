import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repository/FirebaseRepository.dart';

part 'add_data_firestore_state.dart';

class AddDataFirestoreCubit extends Cubit<AddDataFirestoreState> {
  FirebaseRepository repository;
  AddDataFirestoreCubit({required this.repository}) : super(AddDataFirestoreInitial(false));

  void addData(String title, String note, String? url) {
    // print(url);
    emit(AddDataFirestoreAdding());
    repository.addData(title,note,url).then((value) => emit(AddDataFirestoreAdded(status: value)));
  }

  void setCheckStateChange(bool checkState){
    print(checkState);
    emit(AddDataFirestoreInitial(checkState));
  }
}
