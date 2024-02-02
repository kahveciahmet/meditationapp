import 'package:meditasyon_projesi_ahmet_kahveci/notlar/NotModelleri/Not_modeli.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotVeritabani{
  NotVeritabani._();
  static final NotVeritabani notdb = NotVeritabani._();
  static Database? _database;

  Future<Database?> get database async{
    if(_database !=null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }
  
  initDB() async{
    return await openDatabase(join(await getDatabasesPath(), "notlar.db"),
      onCreate: (notdb, version) async{
      await notdb.execute('''
      CREATE TABLE notlar(
        notid INTEGER PRIMARY KEY AUTOINCREMENT,
        baslik TEXT,
        body TEXT,
        olusturma_zamani DATE
      )
      ''');

      },version: 1);
  }
  
  yeniNotEkle(NotModeli notModeli) async {
    final notdb = await database;
    notdb?.insert("notlar", notModeli.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> notlariGetir() async{
    final notdb = await database;
    var sonuc = await notdb?.query("notlar");
    if(sonuc!.isEmpty) {
      return Null;
    } else{
      var sonucMap = sonuc.toList();
      return sonucMap.isNotEmpty ? sonucMap : Null;
    }
  }

  Future<int> notuSil(String? baslik) async{
    final notdb = await database;
    int sayac = await notdb!.rawDelete("DELETE FROM notlar WHERE baslik = ?", [baslik]);
    return sayac;
  }
}