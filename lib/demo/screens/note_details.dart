import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_ex_app/demo/sqlite_test/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../sqlite_test/model/note.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  const NoteDetail({super.key, required this.appBarTitle, required this.note});

  @override
  State<NoteDetail> createState() => _NoteDetailState(appBarTitle, this.note);
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;

  static var priorities = ['High', 'Low'];

  //get singleton instance of dbhelper
  DatabaseHelper dbHelper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //constructor
  _NoteDetailState(this.appBarTitle, this.note);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descController.text = note.desc ?? '';

    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(appBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            //first element
            ListTile(
              title: DropdownButton(
                items: priorities.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: getPriorityAsString(note.priority),
                onChanged: (val) {
                  setState(() {
                    debugPrint('user selected $val');
                    //update value
                    updatePriorityAsInt(val!);
                  });
                },
              ),
            ),
            //second element - 2 text area
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (val) {
                  debugPrint('State changed');
                  updateTitle();
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0))),
              ),
            ),
            //third element
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: descController,
                style: textStyle,
                onChanged: (val) {
                  debugPrint('State changed desc');
                  updateDescription();
                },
                decoration: InputDecoration(
                    labelText: 'Desc',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0))),
              ),
            ),
            //4th element -row of btns
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  //save btn
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: const Text('Save'),
                      onPressed: () {
                        setState(() {
                          debugPrint('Pressed save');
                          _save();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  //delete btn
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: const Text('Delete'),
                      onPressed: () {
                        setState(() {
                          debugPrint('Pressed delete');
                          _delete();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //convert str in interge b4 saving to db
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  //convert int to value
  String getPriorityAsString(int value) {
    String priority = '';
    switch (value) {
      case 1:
        priority = priorities[0];
        break;
      case 2:
        priority = priorities[1];
        break;
    }
    return priority;
  }

//update note obj
  void updateTitle() {
    note.title = titleController.text;
  }

//update note obj
  void updateDescription() {
    note.desc = descController.text;
  }

  //save data to db
  void _save() async {
    //navigate back to notelist page
    moveToLastScreen();
    //add date to note obj
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    //case 1 -> update operation
    //case 2 -> new entry
    if (note.id != null) {
      result = await dbHelper.updateNote(note);
    } else {
      result = await dbHelper.insertNote(note);
    }
    //check success of failure
    if (result != 0) {
      //success
      _showAlertDialog('Status', 'Save Success');
    } else {
      //failure
      _showAlertDialog('Status', 'Save Failed');
    }
  }

  void _delete() async {
    //navigate back to last screen
    moveToLastScreen();
    //case 1 -> delete from icon in note list page
    if (note.id == null) {
      _showAlertDialog('Status', 'No note was deleted');
      return;
    }
    //case 2 -> delete from btn in note details page
    int result = await dbHelper.deleteNote(note.id!);
    if (result != 0) {
      _showAlertDialog('Status', 'Delete Success');
    } else {
      _showAlertDialog('Status', 'Error while deleting');
    }
  }

  void _showAlertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
