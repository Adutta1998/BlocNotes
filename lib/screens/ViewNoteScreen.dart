import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/Services/FirebaseService.dart';
import 'package:notes/Services/InternetService.dart';
import 'package:notes/cubit/delete_data_firestore_cubit.dart';
import 'package:notes/cubit/firestore_data_cubit.dart';
import 'package:notes/data/Note.dart';
import 'package:notes/repository/FirebaseRepository.dart';
import 'package:notes/screens/HomeScreen.dart';
import 'package:notes/screens/VideoPlayerScreen.dart';

class ViewNoteScreen extends StatelessWidget {
  Note note;

  ViewNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteDataFirestoreCubit(repository: FirebaseRepository(service: FirebaseService(init: "ViewNote"))),
      child: BlocBuilder<DeleteDataFirestoreCubit, DeleteDataFirestoreState>(
        builder: (context, state) {
          if(state is DeleteDataFirestoreInitial)
            return Scaffold(
              appBar: AppBar(title: Text(note.title),),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.note, style: TextStyle(fontSize: 30.0),),
                      SizedBox(height: 30.0,),
                      if(note.url != null && note.url!.length>0) ElevatedButton(onPressed: (){
                        InternetService().checkConnected().then((value)=>{
                          if(value)
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPlayerScreen(url: note.url.toString(),)))
                          else
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not Connected")))
                        });
                      }, child: Text("Open Video"))
                    ],
                  ),
                ),
              ),
              floatingActionButton: (!note.deleted)?FloatingActionButton.extended(onPressed: () {
                  InternetService().checkConnected().then((value) => {
                    if(value)
                      BlocProvider.of<DeleteDataFirestoreCubit>(context).delete(note.id)
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not Connected")))
                    }
                  });
                },
                  icon: Icon(Icons.delete_forever),
                  label: Text("Send to Trash"),
              ):Container(),
            );


          if(state is DeleteDataFirestoreDeleting)
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          if(state is DeleteDataFirestoreDeleted){
            if(state.status){
              return Scaffold(
                body: Center(child: ElevatedButton(child: Text("Deleted"),onPressed: (){
                  Navigator.pop(context);
                },),),
              );
            }else{
              return Scaffold(body:Center(child: Text("Deletion Aborted!!"),));
            }
          }
          return Text("Delete Screen");
        },
      ),
    );
  }
}
