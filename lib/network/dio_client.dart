import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  final Dio _dio = Dio();
  DioClient();

 Future<Response> get(String endPoint,
      {Map<String, dynamic>? queryParameter}) async {
    try {
      return await _dio.get(endPoint, queryParameters: queryParameter);
    } on Exception {
      rethrow;
    }
  }


  
}
final dioProvider =  Provider<DioClient>((ref)=>DioClient());