import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyRestaurant = 'DAILY_RESTAURANT';

  Future<bool> get isDailyRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurant) ?? false;
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurant, value);
  }
}
