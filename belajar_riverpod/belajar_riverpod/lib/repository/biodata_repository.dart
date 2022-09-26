import 'package:belajar_riverpod/model/biodata_model.dart';
import 'base_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BiodataRepository extends BaseRepository {
  BiodataRepository({required super.dio});

  Future<List<BiodataModel>> load() async {
    final service = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/list_biodata";
    final resp = await get(service: service) as List<dynamic>;

    final result = List<BiodataModel>.empty(growable: true);
    for(final e in resp){
      result.add(BiodataModel.fromJson(e));
    }

    return result;
  }

  Future<List<BiodataModel>> addBiodata(String nama, String umur) async {

    var param = {
      "nama" : nama,
      "umur" : umur
    };

    print(param);

    final service = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/add_biodata";

    final response = await post(service: service,param: param);

    final result = List<BiodataModel>.empty(growable:true);
    for(final e in response){
      result.add(BiodataModel.fromJson(e));      
    }

    return result;
  }

  Future<List<BiodataModel>> editBiodata(String id, String nama, String umur) async {
    var param = {
      "id" : id,
      "nama" : nama,
      "umur" : umur
    };

    final service = "http://192.168.70.6:999/restapi/index.php/belajarbiodata/edit_biodata";
    final response = await post(service: service, param: param);
    final result = List<BiodataModel>.empty(growable: true);
    for(final e in response){
      result.add(BiodataModel.fromJson(e));
    }

    return result;
  } 

}