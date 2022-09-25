
class BiodataModel {
  late String id;
  late String nama;
  late String umur;

  BiodataModel({
    required this.id, 
    required this.nama, 
    required this.umur
  });

  BiodataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nama = json['nama'];
    umur = json['umur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['umur'] = this.umur;
    return data;
  }
}