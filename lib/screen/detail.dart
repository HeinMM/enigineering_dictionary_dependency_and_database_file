import 'package:drift/drift.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_database.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final DictionaryTableData data;
  final DictionaryDatabase database;
  const DetailScreen({required this.database, required this.data, Key? key})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.eng),
      ),
      body: ListView(
        children: [
          StreamBuilder<DictionaryTableData>(
              stream: widget.database.dictionaryDao.getDetail(widget.data.id),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return IconButton(
                      onPressed: () async {
                        if (snapshots.data!.favourite == null ||
                            snapshots.data!.favourite == false) {
                          await widget.database.dictionaryDao
                              .updateWord(DictionaryTableCompanion(
                            id: Value(widget.data.id),
                            eng: Value(widget.data.eng),
                            type: Value(widget.data.type),
                            myan: Value(widget.data.myan),
                            favourite: const Value(true),
                          ));
                        } else {
                          print('hit');
                          await widget.database.dictionaryDao
                              .updateWord(DictionaryTableCompanion(
                            id: Value(widget.data.id),
                            eng: Value(widget.data.eng),
                            type: Value(widget.data.type),
                            myan: Value(widget.data.myan),
                            favourite: Value(false),
                          ));
                        }
                        setState(() {});
                      },
                      icon: (snapshots.data!.favourite == null ||
                              snapshots.data!.favourite == false)
                          ? Icon(Icons.favorite_border)
                          : Icon(Icons.favorite));
                } else if (snapshots.hasData) {
                  return const Center(child: Text("Error"));
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              }),
          ListTile(
            title: Text("English"),
            subtitle: Text(widget.data.eng),
          ),
          const Divider(),
          ListTile(
            title: Text("Type"),
            subtitle: Text(widget.data.type),
          ),
          const Divider(),
          ListTile(
            title: Text("Myanmar"),
            subtitle: Text(widget.data.myan),
          ),
        ],
      ),
    );
  }
}
