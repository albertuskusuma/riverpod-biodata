
class BiodataModel {
  late String idBiodata;
  late String nama;
  late String umur;

  BiodataModel(
      {
      required this.idBiodata,
      required this.nama,
      required this.umur,});

  BiodataModel.fromJson(Map<String, dynamic> json) {
    idBiodata = json['id_biodata'].toString();
    nama = json['nama'].toString();
    umur = json['umur'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_biodata'] = idBiodata;
    data['nama'] = nama;
    data['umur'] = umur;
    return data;
  }
}
