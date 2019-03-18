import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'signupclass.dart';
import 'foodclass.dart';

class Dbhelper{
  Database _db1;
  Future<Database> get db async{
    if(_db1!=null){
      return _db1;
    }
    _db1 = await initdb();
    return db;
  } 
  initdb() async{

    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'food1.db');
    var thedb =openDatabase(path,version :1 , onCreate : _onCreate);
    return thedb;
  }
  _onCreate(Database db , int version) async{
    await db.execute("create table food(restaurantname text , location text , status text)");
    print("table created");
    return db;
  }
  
  void savedetails() async{
    var dbb= await db;
    await dbb.transaction((txn)async{
      return await txn.execute('insert into food values("dine spot","yelahanka","open")');
    });

  }

  Future<List<Food>> displaydetails() async{
    var dbb = await db;
    List<Map> lists = await dbb.rawQuery("select * from food");
    List<Food> list = new List();
    for (int i=0; i < lists.length;i++){
      list.add(Food(lists[i]["restaurantname"],lists[i]["location"],lists[i]["status"]));

    }
    print(list);
    return list;


  }

    

}
