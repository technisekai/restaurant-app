import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search.dart';

class SearchProvider extends ChangeNotifier {
  final ApiServices apiService;

  SearchProvider({required this.apiService, required key}) {
    _fetchAllSearch(key);
  }

  late SearchModel _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchModel get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearch(key) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final search = await apiService.fetchPostSearch('/search?q=$key');
      if (search.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = search;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
