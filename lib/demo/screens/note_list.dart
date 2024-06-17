import 'package:flutter/material.dart';
import 'package:prog_ex_app/demo/screens/note_details.dart';
import 'package:prog_ex_app/demo/sqlite_test/utils/db_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../sqlite_test/model/note.dart';
import 'note_details.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  //get singleton instances of db helper
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Note> noteList = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('notes'),
        backgroundColor: Colors.purple,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        onPressed: () => {
          debugPrint('elevated btn pressed'),
          navigateToDetail(Note(title: '', priority: 2, date: ''), 'Add Note'),
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList[position].priority),
              child: getPriorityIcon(noteList[position].priority),
            ),
            title: Text(noteList[position].title, style: titleStyle),
            subtitle: Text(noteList[position].date),
            trailing: GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              debugPrint('ListTile pressed');
              navigateToDetail(noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  //helper functions
  //return priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  //return priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.play_arrow);
        break;
      case 2:
        return const Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return const Icon(Icons.keyboard_arrow_right);
    }
  }

  //delete helper function
  void _delete(BuildContext context, Note note) async {
    int result = await dbHelper.deleteNote(note.id!);
    //display result using snack bar
    if (result != 0) {
      _showSnackBar(context, 'Note deleted successfully');
      //todo update list view
      updateListView();
    }
  }

  //display snackbar
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(
        appBarTitle: title,
        note: note,
      );
    }));
    if (result == true) {
      //update notelist
      updateListView();
    }
  }

  void updateListView() {
    //get singleton instance from db
    final Future<Database> dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((database) {
      //get list of nodes
      Future<List<Note>> noteListFuture = dbHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}
