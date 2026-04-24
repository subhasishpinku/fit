import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://aipoweredfitness.com/api/',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Response> postRequest(String url, Map<String, dynamic> data) async {
    try {
      print("POST Request to: $url");
      print("Request Data: $data");

      final response = await _dio.post(url, data: data);

      print("Response Status Code: ${response.statusCode}");
      print("Raw Response Data: ${response.data}");

      dynamic resData = response.data;

      // FIX: if the backend returns a JSON STRING, decode it
      if (resData is String) {
        resData = jsonDecode(resData);
      }

      // Also decode inner fields if they are strings
      // if (resData is Map && resData['data'] is String) {
      //   resData['data'] = jsonDecode(resData['data']);
      // }
      if (resData is Map && resData['data'] is String) {
        try {
          resData['data'] = jsonDecode(resData['data']);
        } catch (_) {}
      }
      print("Processed Response: $resData");

      return Response(
        requestOptions: response.requestOptions,
        data: resData,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      print("DioError: ${e.message}");
      print("DioError Response: ${e.response?.data}");
      throw Exception(e.response?.data ?? e.message);
    } catch (e) {
      print("Unexpected Error: $e");
      throw Exception("An unexpected error occurred");
    }
  }

  Future<Map<String, dynamic>> postContractRequest(
    String url,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post(url, data: data);

      dynamic resData = response.data;

      // If backend returns string
      if (resData is String) {
        resData = jsonDecode(resData);
      }

      // Inner data decode
      if (resData is Map && resData["data"] is String) {
        resData["data"] = jsonDecode(resData["data"]);
      }

      print("Contract Response: $resData");
      return resData;
    } on DioException catch (e) {
      print("DioError: ${e.message}");
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Map<String, dynamic>> getContractRequest(
    String url,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParams);

      dynamic resData = response.data;

      if (resData is String) {
        resData = jsonDecode(resData);
      }

      if (resData is Map && resData["data"] is String) {
        resData["data"] = jsonDecode(resData["data"]);
      }

      print("GET Response: $resData");
      return resData;
    } on DioException catch (e) {
      print("GET Error: ${e.response?.data ?? e.message}");
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
