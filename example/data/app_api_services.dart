import 'dart:io';

import 'package:core_api_service/core_api_service.dart';

class AppApiServices {
  static ApiServices run() {
    return ApiServices(
      baseUrl: 'https://weatherapi-com.p.rapidapi.com/',
      acceptHeaders: {
        HttpHeaders.acceptHeader: "accept: application/json",
      },
      bodyHeaders: {
        "X-RapidAPI-Key": "Something api key",
        "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
        "Content-Type": "application/json",
      },
    );
  }
}
