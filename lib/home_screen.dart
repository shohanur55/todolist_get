import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_with_getx/nevigation_drawer.dart';

import 'dbHandler.dart';
import 'inputScreen.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
        ),


        drawer: NDrawer(),

        body: Column(
          children: [
            FutureBuilder(
                future: noteslist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  snapshot.data![index].title.toString()),
                              subtitle: Text(snapshot.data![index].description.toString()),
                              leading:InkWell(
                                 onTap: (){
                                   dbhelper!.deleteOp(snapshot.data![index].id!);
                                   snapshot.data!.remove(snapshot.data![index]);
                                   setState(() {
                                     noteslist = dbhelper!.retrieveData();
                                   });
                                 },

                                  child: Icon(Icons.delete,color: Colors.red,size: 30,)),

                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Text("no data found");
                  }
                })
          ],
        ),




        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add List",style: TextStyle(color: Colors.cyan,fontSize: 28),),
          onPressed: (){
            Get.to(InputScreen());
          },


        ),
      ),
    );
  }
}
