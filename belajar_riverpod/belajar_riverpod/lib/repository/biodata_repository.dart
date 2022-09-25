import 'package:belajar_riverpod/model/biodata_model.dart';
import 'base_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BiodataRepository extends BaseRepository {
  BiodataRepository({required super.dio});

  Future<List<BiodataModel>> load() async {
    // final service = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/list_biodata";
    final service = "http://localhost/restapi/index.php/belajarbiodata/list_biodata";
    final param = {
      "nama":"nama"
    };
    var resp = await get(service: service) as List<dynamic>;

    final List<BiodataModel> result = List.empty(growable: true);
     for (final e in resp) {
      result.add(BiodataModel.fromJson(e));
    }
    return result;
  }

  Future<List<BiodataModel>> getData() async {
    // String apiURL = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/list_biodata";
     final apiURL = "http://localhost/restapi/index.php/belajarbiodata/list_biodata";

    var apiResult = await http.post(Uri.parse(apiURL));
    if(apiResult.statusCode == 200){

      var jsonObject = json.decode(apiResult.body);
      List<dynamic> list = (jsonObject as Map<String, dynamic>)['data'];

      List<BiodataModel> listpush = [];

      for(int i=0; i < list.length; i++){
        listpush.add(BiodataModel.fromJson(list[i]));
      }

      return listpush;
    }
    else{
      return [];
    }
  }
}