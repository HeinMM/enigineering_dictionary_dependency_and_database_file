import 'package:drift/drift.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_database.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_table.dart';
part 'dictionary_dao.g.dart';

@DriftAccessor(tables: [DictionaryTable])
class DictionaryDao extends DatabaseAccessor<DictionaryDatabase>
    with _$DictionaryDaoMixin {
  DictionaryDao(DictionaryDatabase dictionaryDatabase)
      : super(dictionaryDatabase);

  Future<List<DictionaryTableData>> getAllWord() async {
    return await select(dictionaryTable).get();
  }

  Future<List<DictionaryTableData>> searchWord(String words) async {
    return await (select(dictionaryTable)
          ..where((tbl) => tbl.eng.like('$words%')))
        .get();
  }

  Future<List<DictionaryTableData>> favouriderWord() async {
    return await (select(dictionaryTable)
          ..where((tbl) => tbl.favourite.isNotNull()))
        .get();
  }

  Future<bool> updateWord(DictionaryTableCompanion data) async {
    return await update(dictionaryTable).replace(data);
  }

  Stream<DictionaryTableData> getDetail(int id) {
    return (select(dictionaryTable)..where((tbl) => tbl.id.equals(id)))
        .watchSingle();
  }

  Future<List<DictionaryTableData>> getAllFavourites() {
    return (select(dictionaryTable)..where((tbl) => tbl.favourite.equals(true)))
        .get();
  }
}
