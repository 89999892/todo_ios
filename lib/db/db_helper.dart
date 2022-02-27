import 'package:sqflite/sqflite.dart';


import 'package:todome/models/task.dart';
class DBHelper {
  static final String _tableName='task';
static Database _db;
static Future<void> initDB()async{
  if(_db!=null){
    return;
  }
  else
    try{
      var databasesPath = await getDatabasesPath();
      String path = databasesPath+'task.db';
      _db=await openDatabase(path,version: 1,onCreate: (Database db,int version)async{
        await db.execute('CREATE TABLE $_tableName (id INTEGER PRIMARY KEY autoincrement,'
            'title STRING,note STRING,isCompleted INTEGER,'
            'date STRING,startTime STRING,'
            'endTime STRING,color INTEGER,remind INTEGER,'
            'repeat STRING)');

      });

    }catch(e){
    throw(e);
    }
}
static Future<int>insertToDb(Task task)async{
  print('insert to database يحماصة');
  return await _db.insert(_tableName, task.toJson());
}
  static Future<int> deletFromDb(Task task)async{
    print('Task Deleted  يحماصة2323');
    return await _db.delete(_tableName,where: 'id=?',whereArgs: [task.id]);
  }
  static Future<int>updateTaskDb(int id)async{
    print('insert to database يحماصة');
    return await _db.rawUpdate('UPDATE $_tableName SET isCompleted=? WHERE id=? ',[1,id]);
  }
  static Future quaryTasksDb()async{
  print('دالة الquary called');
  return await _db.query(_tableName);
  }
}
