import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class Dbhandler {
  static Database? _db;

  Future<Database?> get dbs async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    var documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory,'note.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT NOT NULL,dates TEXT NOT NULL)"
    );
  }

  Future<noteModel> insert(noteModel modeln) async {
    var dbclient = await dbs;
    await dbclient!.insert("notes", modeln.to_map());
    return modeln;
  }


 Future<List<noteModel>> retrieveData()async{
   var dbclient = await dbs;
   final List<Map<String,Object?>> queryres=await dbclient!.query("notes");
return queryres.map((e) => noteModel.from_map(e)).toList();
 }

 Future<int>deleteOp(int id)async{
   var dbclient = await dbs;
   return await dbclient!.delete(
     "notes",
     where: 'id = ?',
     whereArgs: [id],
   );
 }

 Future<int>updateOp(noteModel modeln)async{
    var dbc=await dbs;
    return await dbc!.update(
      "notes",
      modeln.to_map(),
      where:"id = ?",
      whereArgs: [modeln.id],

    );
 }


}
