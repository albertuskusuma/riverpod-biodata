class BiodataModel {
  late String idBiodata;
  late String nama;
  late String umur;
  late String jenisKelamin;
  late String alamat;
  late String hobi;
  late String isDelete;

  BiodataModel(
    {
      required this.idBiodata,
      required this.nama,
      required this.umur,
      required this.jenisKelamin,
      required this.alamat,
      required this.hobi,
      required this.isDelete
    });

  BiodataModel.fromJson(Map<String, dynamic> json) {
    idBiodata = json['id_biodata'].toString();
    nama = json['nama'];
    umur = json['umur'];
    jenisKelamin = json['jenis_kelamin'];
    alamat = json['alamat'];
    hobi = json['hobi'];
    isDelete = json['is_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_biodata'] = idBiodata;
    data['nama'] = nama;
    data['umur'] = umur;
    data['jenis_kelamin'] = jenisKelamin;
    data['alamat'] = alamat;
    data['hobi'] = hobi;
    data['is_delete'] = isDelete;
    return data;
  }
}
