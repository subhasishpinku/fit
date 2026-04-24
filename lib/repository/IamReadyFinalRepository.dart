import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:aifitness/models/workout_exercise_model.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class IamReadyFinalRepository {
  final Dio _dio;
  static const String BASE_URL = "https://aipoweredfitness.com";

  IamReadyFinalRepository({Dio? dio}) : _dio = dio ?? _createDio();

  static Dio _createDio() {
    Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    ));
    
    // Add custom headers
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'AIFitnessApp/1.0',
    };
    
    // COMPLETE SSL BYPASS - For development only
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // Disable all SSL certificate validation
      client.badCertificateCallback = (cert, host, port) {
        print('⚠️ SSL Certificate validation DISABLED for: $host');
        print('Certificate Subject: ${cert.subject}');
        print('Certificate Issuer: ${cert.issuer}');
        return true; // Accept ALL certificates
      };
      
      // Set connection timeout
      client.connectionTimeout = const Duration(seconds: 60);
      
      return client;
    };
    
    // Add interceptors for debugging
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('📤 ========== REQUEST ==========');
        print('URL: ${options.uri}');
        print('Method: ${options.method}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        print('================================');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('📥 ========== RESPONSE ==========');
        print('Status: ${response.statusCode}');
        print('Data: ${response.data.toString().substring(0, response.data.toString().length > 500 ? 500 : response.data.toString().length)}');
        print('================================');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('❌ ========== ERROR ==========');
        print('Message: ${e.message}');
        print('Type: ${e.type}');
        if (e.response != null) {
          print('Status: ${e.response?.statusCode}');
          print('Data: ${e.response?.data}');
        }
        if (e.error != null) {
          print('Error Details: ${e.error}');
        }
        print('==============================');
        return handler.next(e);
      },
    ));
    
    return dio;
  }

  Future<List<WorkoutExerciseModel>> fetchExercises(
    String deviceId,
    int userId,
    String day,
  ) async {
    try {
      print('🚀 Fetching exercises...');
      print('Device ID: $deviceId');
      print('User ID: $userId');
      print('Day: $day');
      
      final response = await _dio.post(
        "$BASE_URL/api/get-full-body-plan-workouts-new-ai-app",
        data: {
          "device_id": deviceId,
          "user_id": userId,
          "day": day,
        },
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
          followRedirects: true,
          maxRedirects: 5,
        ),
      );

      print('✅ Response received with status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // If data is string, try decode
        final Map<String, dynamic> root = data is Map<String, dynamic>
            ? data
            : jsonDecode(data.toString());

        print('📦 Response root keys: ${root.keys}');
        
        final exercisesRaw = root['data']?['exercises'];
        if (exercisesRaw == null) {
          print('⚠️ No exercises found in response');
          return [];
        }

        // exercisesRaw might be List<Map> or a JSON string
        final List items = exercisesRaw is List
            ? exercisesRaw
            : jsonDecode(exercisesRaw.toString());
            
        print('📊 Found ${items.length} exercises');
            
        final List<WorkoutExerciseModel> list = items.map<WorkoutExerciseModel>(
          (e) {
            final itemMap = e is Map<String, dynamic>
                ? e
                : Map<String, dynamic>.from(e);
            return WorkoutExerciseModel.fromJson(itemMap);
          },
        ).toList();

        return list;
      } else {
        throw Exception("API error: ${response.statusCode} - ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.type}");
      print("❌ Error Message: ${e.message}");
      
      // Handle specific Dio errors with user-friendly messages
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout. Please check your internet connection and try again.");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Server response timeout. The server is taking too long to respond.");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No internet connection. Please check your network and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception("Server error: ${e.response?.statusCode}. Please try again later.");
      } else if (e.type == DioExceptionType.cancel) {
        throw Exception("Request was cancelled.");
      } else if (e.type == DioExceptionType.unknown) {
        if (e.message?.contains('SocketException') ?? false) {
          throw Exception("Network error: Unable to connect to the server. Please check your internet connection.");
        } else if (e.message?.contains('HandshakeException') ?? false) {
          throw Exception("SSL/Network security error. The connection could not be established securely. Please check your internet connection or contact support.");
        } else {
          throw Exception("Network error: ${e.message}");
        }
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      print("❌ Unexpected error: $e");
      rethrow;
    }
  }
  
  // Test connection method
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get(
        "$BASE_URL",
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      print('Connection test response: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}