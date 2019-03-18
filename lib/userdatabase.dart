import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'signupclass.dart';

class Dbhelper{
  Database _db2;
  Future<Database> get db async{
    if(_db2!=null){
      return _db2;
    }
    _db2 = await initdb();
    return db;
  } 
  initdb() async{

    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'food.db');
    var thedb =openDatabase(path,version :1 , onCreate : _onCreate);
    return thedb;
  }
  _onCreate(Database db , int version) async{
    await db.execute("create table signup1(email text , mobile text , password text)");
    print("table created");
    return db;
  }
  
  void savedetails(Signup object) async{
    var dbb= await db;
    await dbb.transaction((txn)async{
      return await txn.execute('insert into signup1 values('+'\''+ object.email+'\''+','+'\''+ object.mobile+'\''+','+'\''+ object.password +'\''+')');
    });

  }
  Future<List<Signup>> getdetailss() async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM signup1');
    
    List<Signup> lists = new List();
    if(list.length !=null){
    for(var i=0;i<(list.length);i++)
    {
      lists.add(Signup(list[i]["email"],list[i]["mobile"],list[i]["password"]));
    }
    }
    return lists;
  }
   Future<bool> logincheck(String email,String password) async{
    
    var dbclient = await db;
    List<Map> list = await dbclient.rawQuery("select * from signup1");
    
    for(int i=0;i<list.length;i++){
      if(list[i]["email"]==email && list[i]["password"]==password){
        return true;
      }
      else{
        continue;
      }
      
    }
    return false ;
  
  }
  }