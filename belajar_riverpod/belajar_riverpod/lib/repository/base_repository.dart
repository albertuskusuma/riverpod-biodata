import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class BaseRepository {
  final Dio dio;

  BaseRepository({required this.dio});

  // post
  Future<dynamic> post({
    required String service,
    required Map<String, dynamic> param
  }) async {
    final response = await dio.post(service, data: jsonEncode(param), options:Options(
      headers: {
        HttpHeaders.contentTypeHeader : "application/json"
      },
      contentType: "application/json",
    ));

    if(response.statusCode != 200) {
      throw BaseRepositoryException(message:"Invalid status code ${response.statusCode}");
    }else{
      if(response.data['status'] == 'OK'){
        return response.data['data'];
      }else{
        throw BaseRepositoryException(message: response.data['message']);
      }
    }
  }

  // get
  Future<dynamic> get({
    required String service
  }) async {
   
    final response = await dio.get(service, options: Options(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      contentType: "application/json"
    ));

    if(response.statusCode != 200){
      throw BaseRepositoryException(message: "invalid status code: ${response.statusCode}");
    }

    if(response.data['status'] != 'OK'){
      throw BaseRepositoryException(message: response.data['message']);
    }else{
      return response.data['data'];
    }
  }
}

class BaseRepositoryException implements Exception {
  final String message;

  BaseRepositoryException({required this.message});
}