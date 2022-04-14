import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_dao.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_table.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'dictionary_database.g.dart';

@DriftDatabase(tables: [DictionaryTable], daos: [DictionaryDao])
class DictionaryDatabase extends _$DictionaryDatabase {
  DictionaryDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'app.db'));

    if (!await file.exists()) {
      //copy state

      final blob = await rootBundle.load('assets/engineering.db');
      final buffer = blob.buffer;
      await file.writeAsBytes(
          buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
    }

    return NativeDatabase(file);
  });
}
