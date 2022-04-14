import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_dao.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_database.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/screen/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
