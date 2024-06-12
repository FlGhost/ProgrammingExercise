import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/note.dart';
//declare singleton obj
//this instance will be init only 1 througout application

class DatabaseHelper {
  static DatabaseHelper? _dbHelper;
  static Database? _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesc = 'desc';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _dbHelper ??= DatabaseHelper._createInstance();
    return _dbHelper!;
  }

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  //function to init db
  Future<Database> initializeDatabase() async {
    //get directory for android
    Directory directory = await getApplicationDocumentsDirectory();
    //define path to db
    String path = '${directory.path}/notes.db';
    //open/create db at given path
    var notesDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      _createDb(db, version);
    });
    return notesDb;
  }

  //execute statements
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //CRUD
  //fetch
  //get list of map in return
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await database;
    //var result = await db
    //    ?.rawQuery('SELECT * FROM $noteTable ORDER BY $colPriority ASC');
    var result = await db?.query(noteTable, orderBy: '$colPriority ASC');
    return result!;
  }

  //insert
  Future<int> insertNote(Note note) async {
    Database? db = await database;
    var result = await db?.insert(noteTable, note.toMap());
    return result!;
  }

  //update
  Future<int> updateNote(Note note) async {
    var db = await database;
    var result = await db?.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result!;
  }

  //del operation
  Future<int> deleteNote(int id) async {
    var db = await database;
    int? result =
        await db?.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result!;
  }

  //get # obj counts
  Future<int> getCount() async {
    Database? db = await database;
    List<Map<String, Object?>>? x =
        await db?.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int? result = Sqflite.firstIntValue(x!);
    return result!;
  }

  //get list of maps from db -> convert to list<Note>
  Future<List<Note>> getNoteList() async {
    //get from database
    var noteMapList = await getNoteMapList();
    //count number of entries
    int count = noteMapList.length;
    //create empty list
    List<Note> noteList = [];
    //copy map obj into notelist
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
