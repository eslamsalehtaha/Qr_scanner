import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'qr_code.dart';
import 'dart:async';

class DB{
  static final DB D=DB.internal();
  static DB internal(){}
  static Database _db;
  Future<Database> create() async{
    if(_db != null) {
      return _db;
    }
    String path= join(await getDatabasesPath(),'QR-scanner.db');
    _db=await openDatabase(path,version: 1,onCreate: (Database b,int v)
    {
      b.execute('create table QR(id INTEGER primary key AUTOINCREMENT,content varchar(500),date varchar(100),type varchar(20),favourite varchar(10),creator varchar(10))');
    } );
    return _db;
  }
  Future<void> insertDB(QR a) async{
    Database v=await create();
   await  v.insert('QR', a.toMap());
  }
  Future<List> query({String d,String type,String favourite,String creator}) async{
    Database v=await create();
    if(type !='All') {
      if(creator !=null)
      return v.rawQuery(
          "SELECT * FROM QR WHERE type LIKE '%" + type +"%' AND creator LIKE '%" + creator + "%' ORDER BY " + d);
    else if (favourite != null)
      return v.rawQuery("SELECT * FROM QR WHERE type LIKE '%" + type +"%' AND favourite LIKE '%" + favourite + "%' ORDER BY " + d);
    else
      return v.rawQuery("SELECT * FROM QR  WHERE  creator= 'scanned' AND type LIKE '%" + type + "%' ORDER BY " + d);
  }
    else
      {    if(creator !=null)
        return v.rawQuery(
            "SELECT * FROM QR WHERE  creator LIKE '%" + creator + "%' ORDER BY " + d);
      else if (favourite != null)
        return v.rawQuery("SELECT * FROM QR WHERE favourite LIKE '%" + favourite + "%' ORDER BY " + d);
      else
        return v.rawQuery("SELECT * FROM QR  WHERE  creator= 'scanned'  ORDER BY " + d);}
  }
  Future<int> delete_all({String type,String favourite,String creator}) async{
    Database v=await create();
    if(type !=null)
    return v.delete('QR',where: 'type=?',whereArgs: [type] );
    else if(favourite !=null)
      return v.delete('QR',where: 'favourite=?',whereArgs: [favourite] );
    else if(creator !=null)
      return v.delete('QR',where: 'creator=?',whereArgs: [creator] );
    else
      return v.delete('QR');
  }
  Future<int> delete(int id) async{
    Database v=await create();
    return v.delete('QR',where: 'id=?',whereArgs: [id]);
  }
  Future<int> updates(QR s) async{
    Database v=await create();
    var c= v.update('QR',s.toMap(),where: 'id=?',whereArgs: [s.id]);
    return c;
  }
}