part of 'delete_data_firestore_cubit.dart';

@immutable
abstract class DeleteDataFirestoreState {}

class DeleteDataFirestoreInitial extends DeleteDataFirestoreState {}
class DeleteDataFirestoreDeleting extends DeleteDataFirestoreState {}
class DeleteDataFirestoreDeleted extends DeleteDataFirestoreState {
  final bool status;

  DeleteDataFirestoreDeleted({required this.status});
}
