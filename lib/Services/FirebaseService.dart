import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/data/Note.dart';

class FirebaseService{
  String init;
  FirebaseService({required this.init});

  Future<List<Map>> fetchNDeleted() async {
    CollectionReference reference = FirebaseFirestore.instance.collection("/Notes");
    var l = await reference.where("deleted",isEqualTo: false).get();
    List<Map> list = l.docs.map((e){
      Map t = e.data() as Map;
      t["id"] = e.id;
      return t;
    }).toList();

    // print(list);
    return list;
  }

  Future<List<Map>> fetchDeleted() async{
    CollectionReference reference = FirebaseFirestore.instance.collection("/Notes");
    var l = await reference.where("deleted",isEqualTo: true).get();
    //List<Map> list = l.docs.map((e) => e.data() as Map).toList();
    List<Map> list = l.docs.map((e){
      Map t = e.data() as Map;
      t["id"] = e.id;
      return t;
    }).toList();
    return list;
  }

  void deleteCollection(String id) async {
    CollectionReference reference = FirebaseFirestore.instance.collection("/Notes");
    // var temp = await reference.doc(id).get();
    print(id);
  }

  Future<bool> addData(Note n) async {
    CollectionReference reference = FirebaseFirestore.instance.collection("/Notes");
    var p = await reference.add({
      'title':n.title,
      'note':n.note,
      'deleted':n.deleted
    });
    if(p.id.length>0){
      return true;
    }
    return false;
  }

}