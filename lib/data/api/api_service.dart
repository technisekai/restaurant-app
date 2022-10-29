import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/detail.dart';
import 'package:restaurant_app/data/model/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  /* get data from api (restaurant) */
  Future<RestaurantListModel> fetchPostRestaurant(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));

    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  /* get data from api (detail) */
  Future<DetailModel> fetchPostDetail(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));

    if (response.statusCode == 200) {
      return DetailModel.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  /* get data from api (search) */
  Future<SearchModel> fetchPostSearch(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));

    if (response.statusCode == 200) {
      return SearchModel.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
