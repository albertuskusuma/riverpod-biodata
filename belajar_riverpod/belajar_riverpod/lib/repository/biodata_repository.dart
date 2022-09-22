import 'package:belajar_riverpod/model/biodata_model.dart';
import 'base_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BiodataRepository extends BaseRepository {
  BiodataRepository({required super.dio});

  Future<List<BiodataModel>> load() async {
    final service = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/list_biodata";
    final resp = await get(service: service);
    // final result = List<BiodataModel>.empty(growable: true);

    final result = List<BiodataModel>.empty(growable: true);

    resp["data"].forEach((key) {
      result.add(BiodataModel.fromJson(key));
    });

    // return list<BiodataModel>;
    // resp.forEach((key, value) {
    //   final model = BiodataModel.fromJson(value);
    // });

    // return result;
    return result;
  }

  Future<List<BiodataModel>> getData() async {
    String apiURL = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/list_biodata";

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