import 'package:flutter/material.dart';
import 'package:prog_ex_app/demo/screens/note_details.dart';
import 'package:prog_ex_app/demo/screens/note_list.dart';
import 'package:prog_ex_app/view/buyer/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Page test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MainScreen(),
    );
  }
}
