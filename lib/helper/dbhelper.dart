import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

// membuat file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:belajar_database/model/data_mhs.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }

    return _dbHelper!;
  }

  Future<Database> initDB() async {
    // menentukan database dari lokasi yang dibuat
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'mhs.db';

    // input dan baca database
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      'CREATE TABLE mahasiswa(
        id INTEGER PRIMARY KEY, 
        namaMhs TEXT, 
        alamat TEXT
      )'
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await database;
    var mapList = await db.query('mahasiswa', orderBy: 'namaMhs');

    return mapList;
  }

  // memasukan data
  Future<int> insert(data_mhs object) async {
    Database db = await database;
    int count = await db.insert("mahasiswa", object.toMap());

    return count;
  }

  // update data
  Future<int> update(data_mhs object) async {
    Database db = await database;
    int count = await db.update(
      "mahasiswa",
      object.toMap(),
      where: 'id=?',
      whereArgs: [object.id],
    );

    return count;
  }

  // delete data
  Future<int> delete(int id) async {
    Database db = await database;
    int count = await db.delete("mahasiswa", where: 'id=?', whereArgs: [id]);

    return count;
  }

  // show data mahasiswa
  Future<List<data_mhs>> getMhsList() async {
    var mhsMapList = await select();
    int count = mhsMapList.length;

    List<data_mhs> mhsList = List<data_mhs>.empty();

    for (int i = 0; i < count; i++) {
      mhsList.add(data_mhs.fromMap(mhsMapList[i]));
    }

    return mhsList;
  }
}
