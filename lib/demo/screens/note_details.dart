import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key});

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  static var priorities = ['High', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                value: 'Low',
                onChanged: (val) {
                  setState(() {
                    debugPrint('user selected $val');
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
                      child: const Text('Save'),
                      onPressed: () {
                        setState(() {
                          debugPrint('Pressed save');
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
                      child: const Text('Delete'),
                      onPressed: () {
                        setState(() {
                          debugPrint('Pressed delete');
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
}
