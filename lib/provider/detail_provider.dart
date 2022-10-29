import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/data/model/detail.dart';

class DetailProvider extends ChangeNotifier {
  final ApiServices apiService;

  DetailProvider({required this.apiService, required idRestaurant}) {
    _fetchDetail(idRestaurant);
  }

  late DetailModel _detailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailModel get result => _detailResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetail(String idRestaurant) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.fetchPostDetail('/detail/$idRestaurant');
      if (detail.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
