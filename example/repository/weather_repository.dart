import 'package:core_api_service/core_api_service.dart';

import '../model/realtime_weather_model.dart';

class WeatherRepository {
  static const String realTimeWeatherUrl = "current.json";

  static Future<RealtimeWeather?> getWeather(Map<String, dynamic> query) async {
    try {
      var res = await ApiServices().get(
        realTimeWeatherUrl,
        query: query,
      );

      return RealtimeWeather.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
