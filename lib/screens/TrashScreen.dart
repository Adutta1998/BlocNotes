import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/firestore_data_cubit.dart';

import 'NoteTile.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FirestoreDataCubit>(context).fetchDeletedCollections();
    return BlocBuilder<FirestoreDataCubit, FirestoreDataState>(
      builder: (_,state){
        if(state is FirestoreDeletedDataLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is FirestoreDataDeletedLoaded){
          return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_,index){
                return NoteTile(n: state.notes[index],homeContext: context,);
              }
          );
        }
        return Text("hello");
      },
    );
  }
}
