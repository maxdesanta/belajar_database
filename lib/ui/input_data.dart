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

  // Controllers for text fields
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController hobiController = TextEditingController();

  String jenisKelamin = "laki-laki";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (data_mahasiswa != null) {
      namaController.text = data_mahasiswa!.namaMhs;
      nimController.text = data_mahasiswa!.nim;
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
                  style: TextStyle(color: Colors.white),
                )
                : Text(
                  'Edit Data Mahasiswa',
                  style: TextStyle(color: Colors.white),
                ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Header
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Card(
                  elevation: 2,
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data_mahasiswa == null
                              ? 'Form Data Mahasiswa Baru'
                              : 'Form Edit Data Mahasiswa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Silahkan isi data dengan lengkap',
                          style: TextStyle(color: Colors.blue.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Basic Info Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Dasar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Nama field
                      TextFormField(
                        controller: namaController,
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          prefixIcon: Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          // Validate only letters and spaces are entered
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return 'Nama hanya boleh berisi huruf';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // NIM field
                      TextFormField(
                        controller: nimController,
                        decoration: InputDecoration(
                          labelText: 'NIM',
                          prefixIcon: Icon(Icons.badge, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'NIM tidak boleh kosong';
                          }
                          // Validate only numbers are entered
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'NIM hanya boleh berisi angka';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Alamat field
                      TextFormField(
                        controller: alamatController,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          prefixIcon: Icon(Icons.home, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Alamat tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Tanggal Lahir field
                      TextFormField(
                        controller: tanggalLahirController,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal lahir tidak boleh kosong';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary:
                                        Colors.blue, // header background color
                                    onPrimary:
                                        Colors.white, // header text color
                                    onSurface: Colors.black, // body text color
                                  ),
                                ),
                                child: child!,
                              );
                            },
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
                      SizedBox(height: 16),

                      // Nomor Telepon field
                      TextFormField(
                        controller: nomorTeleponController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                          prefixIcon: Icon(Icons.phone, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor telepon tidak boleh kosong';
                          }
                          // Validate only numbers are entered
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Nomor telepon hanya boleh berisi angka';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Hobi field
                      TextFormField(
                        controller: hobiController,
                        decoration: InputDecoration(
                          labelText: 'Hobi',
                          prefixIcon: Icon(
                            Icons.sports_soccer,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Hobi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Button Row (Batal on left, Simpan on right)
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.cancel, color: Colors.white),
                      label: Text(
                        "Batal",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          data_mhs data;
                          if (data_mahasiswa == null) {
                            // tambah data
                            data = data_mhs(
                              null,
                              namaController.text,
                              nimController.text,
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
                              nimController.text,
                              alamatController.text,
                              tanggalLahirController.text,
                              jenisKelamin,
                              nomorTeleponController.text,
                              hobiController.text,
                            );
                          }
                          Navigator.pop(context, data);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
