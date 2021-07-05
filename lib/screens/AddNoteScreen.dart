import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/Services/FirebaseService.dart';
import 'package:notes/cubit/add_data_firestore_cubit.dart';
import 'package:notes/repository/FirebaseRepository.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({Key? key}) : super(key: key);
  TextEditingController title=TextEditingController(),
      note = TextEditingController(),
      url = TextEditingController();
  FirebaseRepository repository = FirebaseRepository(service: FirebaseService(init: "Firebase"));
  // final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
  create: (context) => AddDataFirestoreCubit(repository: repository),
  child: Scaffold(
      appBar: AppBar(title: Text("Add Note"),),
      body: BlocBuilder<AddDataFirestoreCubit, AddDataFirestoreState>(
  builder: (context, state) {
        if(state is AddDataFirestoreInitial)
        {
          return Form(
            // key: key,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _titleText(),
                    SizedBox(height: 10.0,),
                    _noteText(),
                    SizedBox(height: 10.0,),
                    _videoCheck(context,state.checkedState),
                    SizedBox(height: 10.0,),
                    (state.checkedState)?_urlInput(context):Text(""),
                    _submitButton(context)
                  ],
                ),
              ),
            ),
          );
        }

        if(state is AddDataFirestoreAdding){
          return Center(child: CircularProgressIndicator(),);
        }

        if(state is AddDataFirestoreAdded){
          // return Center(child: Text(state.status.toString()));
          if(state.status)
            return Center(child: ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            },child: Text("Note Added Successfully"),),);
            else
            return Center(child: Text("Something went Wrong"),);
        }
        return Text("Hello");
  },
)
    ),
);
  }

 Widget _noteText() {
    return TextFormField(
      controller: note,
      decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Note"),
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      maxLength: 500,
      validator: (value){
        if(value == null || value.trim().isEmpty)
          return "Note field is mandatory";
        return null;
      },
    );
 }

 Widget _titleText() {
    return TextFormField(
      controller: title,
      validator: (value){
        if(value == null || value.trim().isEmpty)
          return "Title field is mandatory";
        return null;
      },
      decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Title"),
      maxLength: 120,
    );
  }

 Widget _submitButton(context) {
    return ElevatedButton.icon(onPressed:(){
      BlocProvider.of<AddDataFirestoreCubit>(context).addData(title.text.toString(),note.text.toString(),url.text.toString());
    }, icon: Icon(Icons.add), label: Text("Submit"));
 }

 Widget _videoCheck(context,checkedState) {
    return CheckboxListTile(value: checkedState, onChanged: (checkState){
      BlocProvider.of<AddDataFirestoreCubit>(context).setCheckStateChange(checkState!);
    },title: Text("Add Video Url"),);
 }

 Widget _urlInput(BuildContext context) {
    return TextFormField(controller: url,decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Url"),);
 }
}


