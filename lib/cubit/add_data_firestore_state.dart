part of 'add_data_firestore_cubit.dart';

@immutable
abstract class AddDataFirestoreState {}

class AddDataFirestoreInitial extends AddDataFirestoreState {}
class AddDataFirestoreAdding extends AddDataFirestoreState {}
class AddDataFirestoreAdded extends AddDataFirestoreState {
  final bool status;
  AddDataFirestoreAdded({required this.status});
}

class AddDataFirestoreVideoState extends AddDataFirestoreState{
  final bool checkedState;
  AddDataFirestoreVideoState(this.checkedState);
}
