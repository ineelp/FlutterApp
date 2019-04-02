import 'dart:io';
import '../models/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

 // Path provider: https://pub.dartlang.org/packages/path_provider#-installing-tab-
class DatabaseHelper{

  static final DatabaseHelper instance = new DatabaseHelper.internal();

  factory DatabaseHelper () => instance;

  final String tableName = "student";
  final String tokenId = "id";
  final String token = "token";
  

  static Database _db;

  Future<Database> get db async{
    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"maindb.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path,version: 1,onCreate: _onCreate);

    return ourDb;

  }

  void _onCreate(Database db, int version) async{
    await db.execute(
      "CREATE TABLE $tableName($tokenId INTEGER PRIMARY KEY,$token TEXT)"
    );
  }

  //CRUD Operations

//Insertion returns 1 or 0 i.e. Integer

Future<int> saveToken(Student student) async{
    var dbClient = await db;
    int result = await dbClient.insert("$tableName", student.toMap());
    return result;
  }

Future<int> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
}

Future<Student> getToken(int id) async{
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $tokenId = $id");

    if(result.length == 0) return null;

    return new Student.fromMap(result.first);

}

Future close() async{
    var dbClient = await db;
    return dbClient.close();
}
}