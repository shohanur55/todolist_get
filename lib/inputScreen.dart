import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_with_getx/home_screen.dart';

import 'dbHandler.dart';
import 'model.dart';

class InputScreen extends StatefulWidget {
  InputScreen({super.key});
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
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

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Get.to(MyHomePage());
            },

              child: Icon(Icons.arrow_back)),
          title: Text("Input page"),
          backgroundColor: Colors.cyanAccent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.all(30)),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),



            SizedBox(
              height: 30,
            ),





            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
              ),
            ),


            SizedBox(
              height: 30,
            ),



            ElevatedButton(
              onPressed: () {
                 var dof=DateTime.now();
                print(dof);
                dbhelper!
                    .insert(noteModel(
                 // dates:dof,
                  title: titleController.text,
                  description: descriptionController.text,
                ))
                    .then((value) {
                  setState(() {
                    noteslist = dbhelper!.retrieveData();
                  });

                  print("data added");
                }).onError((error, stackTrace) {
                  print("error is the " + error.toString());
                });
              },
              child: Text("submit"),
            )
          ],
        ),
      ),
    );
  }
}
