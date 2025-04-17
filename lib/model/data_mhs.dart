class data_mhs {
  int id;
  String namaMhs;
  String alamat;

  // konstruktor
  data_mhs(this.id, this.namaMhs, this.alamat);

  // konversi ke map
  factory data_mhs.fromMap(Map<String, dynamic> map) => data_mhs(map['idMhs'], map['nama'], map['alamatMhs']);

  // getter and setter mengisi dan mengambil data ke dalam objek

  // getter
  int get idMhs => id;
  String get nama => namaMhs;
  String get alamatMhs => alamat;

  // setter
  set nama(value) {
    nama = value;
  }

  set alamatMhs(value) {
    alamatMhs = value;
  }

  // konversi dari map ke data mhs
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['idMhs'] = id;
    map['nama'] = namaMhs;
    map['alamatMhs'] = alamat;

    return map;
  }
}
