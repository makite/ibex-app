import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiClient {
  var token;
  var baseUrl;

  ApiClient() {
    token = dotenv.get('API_TOKEN');
    baseUrl = dotenv.get('API_BASE_URL');
  }
  final Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(minutes: 7),
      receiveTimeout: const Duration(minutes: 7),
      sendTimeout: const Duration(minutes: 7),
      responseType: ResponseType.json,
      followRedirects: false,
      headers: {
        'Authorization': 'Bearer ${dotenv.get('API_TOKEN')}',
        'Content-Type': 'application/json'
      },
      validateStatus: (status) {
        return true;
      }));

  Map<String, String> headers = {
    'Authorization': 'Bearer ${dotenv.get('API_TOKEN')}'
  };

  Future<Response> get(String url, Map<String, dynamic>? params,
      Map<String, dynamic> urlParams) async {
    try {
      var response = await dio.get("$baseUrl$url", queryParameters: params);
      if (response.data.toString().contains("502 Bad Gateway") ||
          response.data.toString().contains("504 Gateway Time-out")) {
        throw Exception("Server error");
      }
      if (response.statusCode == 401) {
        throw Exception("Not  Found");
      }
      //print(enc);
      return response;
    } catch (e) {
      rethrow;
    }
  }

// i define getCity b/c i t didnt use common baseurl
  Future<Response> getCity(String url, Map<String, dynamic>? params,
      Map<String, dynamic> urlParams) async {
    try {
      var response = await dio.get(url, queryParameters: params);
      if (response.data.toString().contains("502 Bad Gateway") ||
          response.data.toString().contains("504 Gateway Time-out")) {
        throw Exception("Server error");
      }
      if (response.statusCode == 401) {
        throw Exception("Not  Found");
      }
      //print(enc);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
