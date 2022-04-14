// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:enigineering_dictionary_dependency_and_database_file/database/dictionary_database.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/screen/detail.dart';
import 'package:enigineering_dictionary_dependency_and_database_file/screen/favourite.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DictionaryDatabase database = DictionaryDatabase();
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineering dictionary'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (str) {
                setState(() {});
              },
              controller: _search,
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DictionaryTableData>>(
                future: database.dictionaryDao.searchWord(_search.text),
                builder: (context, snapshops) {
                  if (snapshops.hasData) {
                    return ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: snapshops.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                          database: database,
                                          data: snapshops.data![index])));
                            },
                            child: Card(
                                elevation: 0,
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(snapshops.data![index].eng),
                                )),
                          );
                        });
                  } else if (snapshops.hasData) {
                    return const Center(child: Text("Error"));
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FavouriteScreen(database: database)));
        },
      ),
    );
  }
}
