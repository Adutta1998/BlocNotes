import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_data_firestore_state.dart';

class DeleteDataFirestoreCubit extends Cubit<DeleteDataFirestoreState> {
  DeleteDataFirestoreCubit() : super(DeleteDataFirestoreInitial());
}
