import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYonetimi {
  static Database? _database;

  Future<Database> get veritabani async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'kullanici_veritabani.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Kullanicilar(
            kullaniciID STRING PRIMARY KEY,
            isim TEXT,
            soyIsim TEXT,
            kullaniciAdi TEXT,
            email TEXT,
            sifre TEXT
          )
        ''');
      },
    );
  }
}