import 'package:flutter/material.dart';

import 'dbHandler.dart';
import 'model.dart';

class NDrawer extends StatefulWidget {
  const NDrawer({super.key});

  @override
  State<NDrawer> createState() => _NDrawerState();
}

class _NDrawerState extends State<NDrawer> {
  Dbhandler? dbhelper;
  late Future<List<noteModel>> noteslist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper = Dbhandler();
    loading();
  }

  loading() async {
    noteslist = dbhelper!.retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        // backgroundColor: Colors.white,
        child: FutureBuilder(
            future: noteslist,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data![index].title.toString()),
                      ),
                    );
                  },
                );
              } else {
                return Text("no data found");
              }
            }),
      ),
    );
  }
}
