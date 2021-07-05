import 'dart:io';
import 'dart:async';
import 'package:notes/data/Note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {

  final _dbName = "NoteDB.db";
  final _tableName= "notes";

  DatabaseService.init();
  static final DatabaseService instance = DatabaseService.init();

  static Database? _database;

  Future<Database> get database async{
    if(_database!=null) return _database!;
    _database =await initDB(_dbName);
    return _database!;
  }

  Future<Database> initDB(String dbName) async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path,_dbName);
    print(path);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future closeDB() async{
     final db = await instance.database;
     db.close();
  }

  Future _createDB(Database db, int version) async{
    var idType = "TEXT PRIMARY KEY";
    var textType = "TEXT NOT NULL";
    var boolType = "BOOLEAN NOT NULL";
    var urlType = "TEXT";
    await db.execute(
      '''
      CREATE TABLE $_tableName(
        ${NoteFields.id} $idType,
        ${NoteFields.title} $textType,
        ${NoteFields.note} $textType,
        ${NoteFields.deleted} $boolType,
        ${NoteFields.url} $urlType
      );
      '''
    );
  }

  Future<void> insert(List<Note> notes) async{
    final db = await instance.database;
    await db.rawQuery("DELETE FROM $_tableName");
    print("Deleted Previous");
    notes.forEach((note) async{
      await db.insert(_tableName, note.toJson());
    });
  }


  Future<List<Note>> fetchAll() async {
    final db = await instance.database;
    List<Map> rawnotes = await db.query(_tableName);
    print(rawnotes);
    List<Note> notes = rawnotes.map((e) => Note.fromJSON(e)).toList();
    return notes;
  }



}