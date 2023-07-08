import 'dart:io';

import 'package:core_api_service/core_api_service.dart';

import 'model/realtime_weather_error_model.dart';
import 'model/realtime_weather_model.dart';

const String realTimeWeatherUrl = "current.json";

void main() async {
  // initialize Api Service

  ApiServices.initialize(
    baseUrl: 'https://weatherapi-com.p.rapidapi.com/',
    acceptheaders: {
      HttpHeaders.acceptHeader: "accept: application/json",
    },
    bodyHeaders: {
      "X-RapidAPI-Key": "Something API KEY",
      "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
      "Content-Type": "application/json",
    },
  );

  var query = {
    // "q": "London",
    "q": 0, //error param
  };

  // try call repository

  // if Error response match [CoreErrorResponse] then return CoreErrorResponse
  // if not match than will be return String

  // so define your error model base your api

  try {
    var data = await WeatherRepository.getWeather(query);
    print(data?.toJson());
  } catch (e) {
    if (e is String) {
      ErrorRealtimeWeather error = ErrorRealtimeWeather.fromJson(e);
      print(error.toJson());
    }
  }
}

// Define Something Model

//  'model/realtime_weather_error_model.dart';
//  'model/realtime_weather_model.dart';

// Define Something Repository

class WeatherRepository {
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
