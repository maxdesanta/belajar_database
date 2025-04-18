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
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/data_mhs.db';
    print(directory.path);

    var dataMhsDatabase = openDatabase(
      path,
      version: 2, // Versi dinaikkan menjadi 2
      onCreate: _createDb,
      onUpgrade: _upgradeDb
    );

    return dataMhsDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data_mhs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        namaMhs TEXT,
        alamat TEXT
      )
    ''');
  }

  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Membuat tabel baru dengan skema lengkap
      await db.execute('''
        CREATE TABLE data_mhs_new (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          namaMhs TEXT,
          alamat TEXT,
          tanggalLahir TEXT,
          jenisKelamin TEXT,
          nomorTelepon TEXT,
          hobi TEXT
        )
      ''');

      // Menyalin data dari tabel lama ke tabel baru
      await db.execute('''
        INSERT INTO data_mhs_new (id, namaMhs, alamat)
        SELECT id, namaMhs, alamat FROM data_mhs
      ''');

      // Menghapus tabel lama
      await db.execute('DROP TABLE data_mhs');

      // Mengganti nama tabel baru menjadi nama asli
      await db.execute('ALTER TABLE data_mhs_new RENAME TO data_mhs');
    }
  }

  // Operasi Insert: Menyisipkan data_mhs baru dan mendapatkan idnya
  Future<int> insert(data_mhs object) async {
    Database db = await this.initDB();
    try {
      int count = await db.insert('data_mhs', object.toMap());
      return count;
    } catch (e) {
      print("Error saat menyisipkan data: $e");
      return -1;
    }
  }

  // Mendapatkan jumlah record data_mhs
  Future<int> getCount() async {
    Database db = await this.initDB();
    try {
      List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM data_mhs');
      int result = Sqflite.firstIntValue(x) ?? 0;
      return result;
    } catch (e) {
      print("Error saat mendapatkan jumlah: $e");
      return -1;
    }
  }

  // Mendapatkan daftar 'data_mhs'
  Future<List<data_mhs>> getMhsList() async {
    var dataMhsMapList = await getMhsMapList(); // Mendapatkan daftar 'data_mhs' dalam bentuk map
    int count = dataMhsMapList.length; // Menghitung jumlah entri map dalam tabel db
    List<data_mhs> dataMhsList = <data_mhs>[];

    // Loop untuk membuat daftar 'data_mhs' dari daftar 'Map'
    for (int i = 0; i < count; i++) {
      dataMhsList.add(data_mhs.fromMapObject(dataMhsMapList[i]));
    }

    return dataMhsList;
  }

  // Mendapatkan daftar 'data_mhs' dalam bentuk map: setiap elemen adalah baris dalam bentuk Map<String, dynamic>
  Future<List<Map<String, dynamic>>> getMhsMapList() async {
    Database db = await this.initDB();
    try {
      var result = await db.query('data_mhs');
      return result;
    } catch (e) {
      print("Error saat mendapatkan map list: $e");
      return [];
    }
  }

  // Operasi Update: Memperbarui data_mhs dan mendapatkan jumlah baris yang terpengaruh
  Future<int> update(data_mhs object) async {
    Database db = await this.initDB();
    try {
      int result = await db.update(
        'data_mhs',
        object.toMap(),
        where: 'id = ?',
        whereArgs: [object.id],
      );
      return result;
    } catch (e) {
      print("Error saat memperbarui data: $e");
      return -1;
    }
  }

  // Operasi Delete: Menghapus data_mhs
  Future<int> delete(int id) async {
    Database db = await this.initDB();
    try {
      int result = await db.rawDelete('DELETE FROM data_mhs WHERE id = $id');
      return result;
    } catch (e) {
      print("Error saat menghapus data: $e");
      return -1;
    }
  }
}
