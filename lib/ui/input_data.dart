import 'package:flutter/material.dart';
import 'package:belajar_database/model/data_mhs.dart';

class InputData extends StatefulWidget {
  final data_mhs? data_mahasiswa;
  InputData(this.data_mahasiswa);

  @override
  _InputDataState createState() => _InputDataState(this.data_mahasiswa);
}

class _InputDataState extends State<InputData> {
  final data_mhs? data_mahasiswa;
  _InputDataState(this.data_mahasiswa);
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController hobiController = TextEditingController();

  String jenisKelamin = "Laki-laki";

  @override
  void initState() {
    super.initState();
    if (data_mahasiswa != null) {
      namaController.text = data_mahasiswa!.namaMhs;
      alamatController.text = data_mahasiswa!.alamat;
      tanggalLahirController.text = data_mahasiswa!.tanggalLahir;
      nomorTeleponController.text = data_mahasiswa!.nomorTelepon;
      hobiController.text = data_mahasiswa!.hobi;
      jenisKelamin = data_mahasiswa!.jenisKelamin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            data_mahasiswa == null
                ? Text(
                  'Tambah Data Mahasiswa',
                  style: TextStyle(color: Color(0XFFfffefb)),
                  )
                : Text(
                  'Edit Data Mahasiswa',
                  style: TextStyle(color: Color(0XFFfffefb))
                ),
        leading: Icon(Icons.keyboard_arrow_left),
        backgroundColor: Color(0xff00668c),
      ),
      backgroundColor: Color(0xfffffefb),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 8, right: 8),
        child: ListView(
          children: <Widget>[
            // nama
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
            // alamat
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                onChanged: (value) => {},
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                controller: alamatController,
              ),
            ),
            // tanggal lahir
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                onChanged: (value) => {},
                decoration: InputDecoration(
                  labelText: 'Tanggal lahir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                controller: tanggalLahirController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    setState(() {
                      tanggalLahirController.text = formattedDate;
                    });
                  }
                },
              ),
            ),
            // nomor telepon
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                onChanged: (value) => {},
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                controller: nomorTeleponController,
                keyboardType: TextInputType.phone,
              ),
            ),
            // jenis kelamin
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Jenis Kelamin"),
                  RadioListTile(
                    value: "laki-laki",
                    title: Text("Laki-laki"),
                    groupValue: jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    value: "perempuan",
                    title: Text("Perempuan"),
                    groupValue: jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            // hobi
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                onChanged: (value) => {},
                decoration: InputDecoration(
                  labelText: 'Hobi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                controller: hobiController,
                maxLines: null,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        data_mhs data;
                        if (data_mahasiswa == null) {
                          // tambah data
                          data = data_mhs(
                            null,
                            namaController.text,
                            alamatController.text,
                            tanggalLahirController.text,
                            jenisKelamin,
                            nomorTeleponController.text,
                            hobiController.text,
                          );
                        } else {
                          // edit data
                          data = data_mhs(
                            data_mahasiswa!.id,
                            namaController.text,
                            alamatController.text,
                            tanggalLahirController.text,
                            jenisKelamin,
                            nomorTeleponController.text,
                            hobiController.text,
                          );
                        }

                        Navigator.pop(context, data);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                      ),

                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context, data_mahasiswa);
                      },
                      child: Text(
                        "Batal",
                        style: TextStyle(color: Colors.white),
                      ),
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
