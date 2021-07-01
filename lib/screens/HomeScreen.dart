
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/firestore_data_cubit.dart';
import 'package:notes/cubit/navigation_cubit.dart';
import 'package:notes/screens/AddNoteScreen.dart';
import 'package:notes/screens/NotesScreen.dart';

import 'TrashScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit,NavigationState>(
          builder:(_,state){
            if(state is NavigationInitial){
              return NotesScreen();
            }
            if(state is NavigationNavigate){
              var index = state.navigationIndex;
              if(index==0){
                return NotesScreen();
              } else if(index==1){
                return TrashScreen();
              }
            }
            return Text("Not Null");
          }
      ),
      bottomNavigationBar: _navbar(context),
      floatingActionButton: _fab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}



Widget _navbar(context) {

  return BlocBuilder<NavigationCubit,NavigationState>(
      builder:(_,state){
        var idx = (state is NavigationInitial)?(state).navigationIndex:(state as NavigationNavigate).navigationIndex;

        return BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.delete_outlined,),label:"Trash"),
        ],
          currentIndex: idx,
          onTap:(index){
            BlocProvider.of<NavigationCubit>(context).setNavigation(index);
          },
        );
      }
  );
}


Widget _fab(context) {
  return FloatingActionButton(onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNoteScreen())).then((value) => (context as Element).markNeedsBuild());
  },child: Icon(Icons.add),);
}

