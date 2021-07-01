import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/Services/FirebaseService.dart';
import 'package:notes/data/Note.dart';

class FirebaseRepository{
  final FirebaseService service;

  FirebaseRepository({required this.service});

  Future<List<Note>> fetchNotDeletedCollections() async {
    List<Note> notes;
    List<Map> rawnotes = await service.fetchNDeleted();
    print(rawnotes);
    notes = rawnotes.map((e) => Note.fromJSON(e)).toList();
    return notes;
  }

  Future<List<Note>> fetchDeletedCollections() async {
    List<Map> rawnotes = await service.fetchDeleted();
    List<Note> notes = rawnotes.map((e) => Note.fromJSON(e)).toList();
    return notes;
  }

  void deleteCollection(String id) {
    service.deleteCollection(id);
  }

  Future<bool> addData(String title, String note) async {
    Note n = Note(id: "0", title: title, note: note, deleted: false);
    bool p = await service.addData(n);
    return p;
  }

}