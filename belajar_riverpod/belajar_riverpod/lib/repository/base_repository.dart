import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class BaseRepository {
  final Dio dio;

  BaseRepository({required this.dio});

  Future<Map<String, dynamic>> post({
    required Map<String, dynamic> param,
    required String service
  }) async {
    try {
      final response = await dio.post(
        service,
        data: jsonEncode(param),
        options: Options(
          headers:{
            HttpHeaders.contentTypeHeader: "application/json",
          },
          contentType: "application/json"
        )
      );
      if(response.statusCode != 200){
        throw BaseRepositoryException(message: "Invalid HTTP Response ${response.statusCode}");
      }

      Map<String, dynamic> jsonData = jsonDecode(response.data);
      if(jsonData['status'] != "OK"){
        throw BaseRepositoryException(message: jsonData['message']);
      }else{
        return jsonData;
      }
    } on DioError catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on SocketException catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on BaseRepositoryException catch (e) {
      throw BaseRepositoryException(message: e.message);
    }
  }

  Future<dynamic> get ({
    required String service
  }) async {
    try {
      final response = await dio.get(
        service,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          contentType: "application/json"
        )
      );

      if(response.statusCode != 200){
        throw BaseRepositoryException(message: "invalid Http Response ${response.statusCode}");
      }

      // Map<String, dynamic> jsonData = json.decode(response.data);

      if(response.data['status'] != "OK"){
        throw BaseRepositoryException(message:response.data['message']);
      }else{
        if(response.data['status'] == 'OK'){
          return response.data['data'];
        }else{
          throw BaseRepositoryException(message:response.data['message']);
        }
      }
    } on DioError catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on SocketException catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on BaseRepositoryException catch (e) {
      throw BaseRepositoryException(message: e.message);
    }
  }
}

class BaseRepositoryException implements Exception {
  final String message;

  BaseRepositoryException({required this.message});
}