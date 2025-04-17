import 'package:flutter/material.dart';
import 'package:belajar_database/ui/input_data.dart';
import 'package:belajar_database/helper/dbhelper.dart';
import 'package:belajar_database/model/data_mhs.dart';

// import sqlite
import 'package:sqflite/sqflite.dart';

// import async
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DbHelper dbHelper;
  int count = 0;
  List<data_mhs> dataMhs = List<data_mhs>.empty();

  @override
  Widget build(BuildContext context) {
    if (dataMhs == null) {
      dataMhs = List<data_mhs>.empty();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await navigateToEntryForm(context, null);
          if (data != null) {
            insertData(data);
          }
        },
        tooltip: 'Tambah Data',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future navigateToEntryForm(BuildContext context, data_mhs? data) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return input_data(d_mhs);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Icon(Icons.people),
            ),
            title: Text(dataMhs[index].namaMhs),
            subtitle: Text(dataMhs[index].alamat),
            trailing: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                deleteContact(dataMhs[index]);
              },
            ),
            onTap: () async {
              var data = await navigateToEntryForm(context, dataMhs[index]);
              if (data != null) {
                editData(data);
              }
            },
          ),
        );
      },
    );
  }
}

// tambah data
void insertData(data_mhs object) async {
  int result = await DbHelper().insert(object);
  if (result > 0) {
    updateListView();
  }
}

// edit data
void editData(data_mhs object) async {
  int result = await DbHelper().update(object);
  if (result > 0) {
    updateListView();
  }
}

// hapus kontak
void deleteContact(data_mhs object) async {
  int result = await DbHelper().delete(object.id);
  if (result > 0) {
    updateListView();
  }
}

void updateListView() {
  final Future<Database> dbFuture = DbHelper().initDB();

  dbFuture.then((database) {
    Future<List<data_mhs>> contactListFuture = DbHelper().getMhsList();

    contactListFuture.then((contactList) {
      setState(() {
        this.mhsList = contactList;
        this.count = contactList.length;
      })
    });
  });
}
