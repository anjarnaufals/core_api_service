import '../data/app_api_services.dart';
import '../model/realtime_weather_model.dart';

class WeatherRepository {
  static const String realTimeWeatherUrl = "current.json";

  static Future<RealtimeWeather?> getWeather(Map<String, dynamic> query) async {
    try {
      var res = await AppApiServices.run().get(
        realTimeWeatherUrl,
        query: query,
      );

      return RealtimeWeather.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  static Future<RealtimeWeather?> getWeatherJakarta(
    Map<String, dynamic> query,
  ) async {
    try {
      var res = await AppApiServices.run().get(
        realTimeWeatherUrl,
        query: query,
      );

      return RealtimeWeather.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
