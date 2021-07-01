import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repository/FirebaseRepository.dart';

part 'delete_data_firestore_state.dart';

class DeleteDataFirestoreCubit extends Cubit<DeleteDataFirestoreState> {
  FirebaseRepository repository;
  DeleteDataFirestoreCubit({required this.repository}) : super(DeleteDataFirestoreInitial());

  void delete(String id) {
    emit(DeleteDataFirestoreDeleting());
    repository.markTrashed(id).then((value) => emit(DeleteDataFirestoreDeleted(status: value)));
  }
}
