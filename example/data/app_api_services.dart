import 'dart:io';

import 'package:core_api_service/core_api_service.dart';

class AppApiServices {
  static void init() {
    ApiServices().initialize(
      initBaseUrl: 'https://weatherapi-com.p.rapidapi.com/',
      initAcceptheaders: {
        HttpHeaders.acceptHeader: "accept: application/json",
      },
      initBodyHeaders: {
        "X-RapidAPI-Key": "Somehting API key",
        "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
        "Content-Type": "application/json",
      },
    );
  }

  static updateHeader(Map<String, dynamic> headers) {
    ApiServices().updateHeaders(headers);
  }
}
