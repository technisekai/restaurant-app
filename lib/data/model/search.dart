import 'package:restaurant_app/data/model/restaurant_list.dart';

class SearchModel {
  SearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
