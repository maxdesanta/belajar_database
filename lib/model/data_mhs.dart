class data_mhs {
  int? id;
  String namaMhs;
  String alamat;
  String tanggalLahir;
  String jenisKelamin;
  String nomorTelepon;
  String hobi;

  data_mhs(
    this.id,
    this.namaMhs,
    this.alamat,
    this.tanggalLahir,
    this.jenisKelamin,
    this.nomorTelepon,
    this.hobi,
  );

  // Convert a data_mhs object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'namaMhs': namaMhs, 'alamat': alamat, 'tanggalLahir': tanggalLahir, 'jenisKelamin': jenisKelamin, 'nomorTelepon': nomorTelepon, 'hobi': hobi};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory data_mhs.fromMapObject(Map<String, dynamic> map) {
    return data_mhs(
      map['id'],
      map['namaMhs'],
      map['alamat'],
      map['tanggalLahir'],
      map['jenisKelamin'],
      map['nomorTelepon'],
      map['hobi'],
    );
  }
}
