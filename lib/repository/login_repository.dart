import 'package:dio/dio.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class LoginRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://aipoweredfitness.com/api/",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post("login", data: request.toJson());

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}
