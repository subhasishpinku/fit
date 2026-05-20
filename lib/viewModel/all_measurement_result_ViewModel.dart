import 'package:aifitness/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMeasurementResultViewmodel extends ChangeNotifier {

  final ApiService _apiService = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  List<dynamic> _measurementList = [];
  List<dynamic> get measurementList => _measurementList;

  String _error = '';
  String get error => _error;

Future<void> getMachineLogs(String userId) async {

  _loading = true;
  _error = '';

  notifyListeners();

  try {

    final response = await _apiService.postRequest(
      'get-machine-logs',
      {
        "user_id": userId,
      },
    );

    print(response.data);

    if (response.statusCode == 200) {

      final responseData = response.data['data'];

      if (responseData != null &&
          responseData['data'] != null) {

        _measurementList =
            List<dynamic>.from(responseData['data']);

      } else {

        _measurementList = [];
      }

    } else {

      _error = "Something went wrong";
    }

  } catch (e) {

    _error = e.toString();

    print(e);
  }

  _loading = false;

  notifyListeners();
}
}
