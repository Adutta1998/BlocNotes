import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/Services/FirebaseService.dart';
import 'package:notes/cubit/firestore_data_cubit.dart';
import 'package:notes/cubit/navigation_cubit.dart';
import 'package:notes/repository/FirebaseRepository.dart';
import 'package:notes/screens/HomeScreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.clearPersistence();
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  RootApp({Key? key}) : super(key: key);
  final FirebaseRepository repository = FirebaseRepository(service: FirebaseService(init: "Hello"));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context)=>NavigationCubit(),
        child: BlocProvider(
            create: (context)=>FirestoreDataCubit(repository: repository),
          child: HomeScreen(),
        )
      )
    );
  }
}
