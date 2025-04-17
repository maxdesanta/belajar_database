import 'package:flutter/material.dart';
import 'package:belajar_database/model/data_mhs.dart';

class InputData extends StatefulWidget {
  final data_mhs data_mahasiswa;
  InputData(this.data_mahasiswa);

  @override
  _InputDataState createState() => _InputDataState(this.data_mahasiswa);
}

class _InputDataState extends State<InputData> {
  final data_mhs data_mahasiswa;
  _InputDataState(this.data_mahasiswa);
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // kondisi
    if (data_mahasiswa != null) {
      namaController.text = data_mahasiswa.nama;
      alamatController.text = data_mahasiswa.alamat;
    }

    return Scaffold(
      appBar: AppBar(
        title:
            data_mahasiswa == null
                ? Text('Tambah Data Mahasiswa')
                : Text('Edit Data Mahasiswa'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            // nama
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                onChanged: (value) => {},
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                controller: namaController,
              ),
            ),
            // telepon
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                onChanged: (value) => {},
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                controller: alamatController,
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (data_mahasiswa == null) {
                          // tambah data
                          data_mahasiswa = data_mhs(
                            data_mahasiswa.id,
                            namaController.text,
                            alamatController.text,
                          );
                        } else {
                          // edit data
                          data_mahasiswa.nama = namaController.text;
                          data_mahasiswa.alamat = alamatController.text;
                        }

                        Navigator.pop(context, data_mahasiswa);
                      },
                      child: Text("Simpan"),
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, data_mahasiswa);
                      },
                      child: Text("Batal"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
