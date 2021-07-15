import 'dart:async';
import 'package:sqflite/sqflite.dart';

class StudentModel {

  FutureOr<void> onCreate(Database db, int version) {
    String sqlRaw = '''
        
    CREATE TABLE IF NOT EXISTS siswa(
    id_siswa INTEGER PRIMARY KEY NOT NULL,
    first_name TEXT(20),
    last_name TEXT(20),
    gender TEXT(6),
    grade TEXT(3),
    address TEXT(45),
    mobile_phone TEXT(13),
    hobbies TEXT
    );
    
    ''';

    db.execute(sqlRaw);
  }

  FutureOr<void> onConfigure(Database db) {
  }

  FutureOr<void> onDowngrade(Database db, int oldVersion, int newVersion) {
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
  }
}