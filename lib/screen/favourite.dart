import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_database.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/screen/detail.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  final DictionaryDatabase database;
  const FavouriteScreen({required this.database, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: FutureBuilder<List<DictionaryTableData>>(
        future: database.dictionaryDao.getAllFavourites(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: snapshots.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                  database: database,
                                  data: snapshots.data![index])));
                    },
                    child: Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(snapshots.data![index].eng),
                        )),
                  );
                });
          } else if (snapshots.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
