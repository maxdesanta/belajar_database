import 'package:flutter/material.dart';
import 'package:belajar_database/model/data_mhs.dart';
import 'package:belajar_database/helper/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'input_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  List<data_mhs> listMhs = [];
  String _searchQuery = "";
  String _sortOrder = "ASC"; // Default sort order
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  // Method for updating the ListView
  Future<void> updateListView() async {
    final Future<Database> dbFuture = dbHelper.initDB();
    dbFuture.then((database) {
      // Call getMhsMapList with search query and sort order
      Future<List<Map<String, dynamic>>> mapFuture = 
          dbHelper.getMhsMapList(
            query: _searchQuery.isEmpty ? null : _searchQuery,
            sortOrder: _sortOrder
          );
      mapFuture.then((dataMhsMapList) {
        setState(() {
          int count = dataMhsMapList.length;
          listMhs = [];
          for (int i = 0; i < count; i++) {
            listMhs.add(data_mhs.fromMapObject(dataMhsMapList[i]));
          }
        });
      });
    });
  }

  // Toggle sort order and refresh list
  void _toggleSortOrder() {
    setState(() {
      _sortOrder = _sortOrder == "ASC" ? "DESC" : "ASC";
      updateListView();
    });
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = "";
      _searchController.clear();
      updateListView();
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Cari nama atau NIM...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
          updateListView();
        });
      },
    );
  }

  // Build App Bar based on searching state
  Widget _buildAppBar() {
    if (_isSearching) {
      return AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _cancelSearch,
        ),
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              if (_searchController.text.isEmpty) {
                _cancelSearch();
              } else {
                _searchController.clear();
                setState(() {
                  _searchQuery = "";
                  updateListView();
                });
              }
            },
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Daftar Mahasiswa',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // Sort button
          IconButton(
            icon: Icon(
              _sortOrder == "ASC" 
                ? Icons.arrow_upward 
                : Icons.arrow_downward,
              color: Colors.white,
            ),
            tooltip: _sortOrder == "ASC" 
                ? "Urutkan nama Z-A" 
                : "Urutkan nama A-Z",
            onPressed: _toggleSortOrder,
          ),
          // Search button
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: _startSearch,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar() as PreferredSizeWidget,
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            // Info Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Total mahasiswa: ${listMhs.length}',
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        Text(
                          'Hasil pencarian: "${_searchQuery}"',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.blue.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Student List
            Expanded(
              child: listMhs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? 'Belum ada data mahasiswa'
                                : 'Tidak ada hasil untuk "$_searchQuery"',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listMhs.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.only(bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              listMhs[index].namaMhs,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  'NIM: ${listMhs[index].nim}',
                                  style: TextStyle(color: Colors.blue.shade700),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Edit Button
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InputData(listMhs[index]),
                                      ),
                                    );
                                    if (result != null) {
                                      int updateCount = await dbHelper.update(result);
                                      if (updateCount > 0) {
                                        updateListView();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Data berhasil diperbarui"),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                                // Delete Button
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDelete(context, listMhs[index]);
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              _showDetailDialog(context, listMhs[index]);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputData(null),
            ),
          );
          if (result != null) {
            int insertedId = await dbHelper.insert(result);
            if (insertedId > 0) {
              updateListView();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Data berhasil ditambahkan"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ),
              );
            }
          }
        },
      ),
    );
  }

  // Dialog to confirm deletion
  void _confirmDelete(BuildContext context, data_mhs mhs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data ${mhs.namaMhs}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop();
                int deletedId = await dbHelper.delete(mhs.id!);
                if (deletedId > 0) {
                  updateListView();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Data berhasil dihapus"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Show student details dialog
  void _showDetailDialog(BuildContext context, data_mhs mhs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Mahasiswa'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailItem('Nama', mhs.namaMhs),
                _detailItem('NIM', mhs.nim),
                _detailItem('Alamat', mhs.alamat),
                _detailItem('Tanggal Lahir', mhs.tanggalLahir),
                _detailItem('Jenis Kelamin', mhs.jenisKelamin),
                _detailItem('Nomor Telepon', mhs.nomorTelepon),
                _detailItem('Hobi', mhs.hobi),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper method to create detail item widgets
  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value.isEmpty ? '-' : value,
            style: TextStyle(fontSize: 16),
          ),
          Divider(),
        ],
      ),
    );
  }
}