import 'dart:io';

import 'package:sekolahku/model/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'teacher_model.dart';

TeacherModelProvider _studentModelProvider;

class TeacherModelProvider {
  TeacherModelProvider(this.dbName, this.dbVersion);

  static TeacherModelProvider getInstance(){
    if(_studentModelProvider != null && _studentModelProvider is TeacherModelProvider){
      return _studentModelProvider;
    }

    _studentModelProvider = TeacherModelProvider('sekolahku_flutter_teacher.db', 1);

    return _studentModelProvider;
  }

  final String dbName;
  final int dbVersion;
  Database _database;

  Future<Database> openDb() async{
    var databaseDirectory = await getDatabasesPath();

    try{
      await Directory(databaseDirectory).create(recursive: true);
    }catch (e){
      print('Error Database : '+e);
    }

    var path = join(databaseDirectory, dbName);
    var studentModel = TeacherModel();

    _database = await openDatabase(
        path,
        version: dbVersion,
        onCreate: studentModel.onCreate,
        onConfigure: studentModel.onConfigure,
        onDowngrade: studentModel.onDowngrade,
        onUpgrade: studentModel.onUpgrade
    );
  }

  Future<void> closeDb() async{
    return getDatabase().then((value) => value.close());
  }

  Future<Database> getDatabase() async{
    if(_database == null) throw 'Database is not open';

    return _database;
  }
}