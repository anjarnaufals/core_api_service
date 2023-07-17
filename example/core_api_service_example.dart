import 'data/app_api_services.dart';
import 'model/realtime_weather_error_model.dart';
import 'repository/weather_repository.dart';

void main() async {
  // *initialize Api Service

  AppApiServices.init();

  // update headers
  // ApiServices.updateHeaders({"token": "something token"});

  // *Define Something Model
  //  'model/realtime_weather_error_model.dart';
  //  'model/realtime_weather_model.dart';

  // *Define Something Repository
  // 'repository/weather_repository.dart';

  // *if Error response match [CoreErrorResponse] then return CoreErrorResponse
  // *if not match than will be return String

  // *define your error model base your api

  const query = {
    // "q": "London",
    "q": 0, //error param
  };

  // try call repository

  try {
    var data = await WeatherRepository.getWeather(query);
    print(data?.toJson());
  } catch (e) {
    if (e is Map<String, dynamic>) {
      ErrorRealtimeWeather error = ErrorRealtimeWeather.fromMap(e);
      print("ErrorRealtimeWeather ${error.toJson()}");
    }
    print(e.toString());
  }
}
