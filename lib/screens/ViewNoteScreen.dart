import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/firestore_data_cubit.dart';
import 'package:notes/data/Note.dart';

class ViewNoteScreen extends StatelessWidget {
  Note note;
  ViewNoteScreen({Key? key,required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.title),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(note.note,style: TextStyle(fontSize: 30.0),),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
      }, icon: Icon(Icons.delete_forever), label: Text("Send to Trash")),
    );
  }
}
