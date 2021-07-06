import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/firestore_data_cubit.dart';
import 'package:notes/screens/NoteTile.dart';

class NotesScreen extends StatelessWidget {
  final BuildContext homeContext;
  const NotesScreen({Key? key,required this.homeContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FirestoreDataCubit>(context).fetchNotDeletedCollections();
    return BlocBuilder<FirestoreDataCubit, FirestoreDataState>(
      builder: (_,state){
        if(state is FirestoreDataLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is FirestoreDataLoaded){
          return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_,index){
                return NoteTile(n: state.notes[index],homeContext: homeContext,);
              }
          );
        }
        return Text("hello");
      },
    );
  }
}
