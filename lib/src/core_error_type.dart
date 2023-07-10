import 'package:core_api_service/src/core_error_response.dart';

class CoreErrorType {
  static CoreErrorResponse get noConnection => CoreErrorResponse(
        status: "No Connection",
        message: "Please make sure that your WIFI/Mobile data is active.",
      );

  static CoreErrorResponse get requestTimeOut => CoreErrorResponse(
        status: "Request Time Out",
        message: "There is a network disruption, please try again.",
      );

  static CoreErrorResponse get somethingWrong => CoreErrorResponse(
        status: "Something Wrong",
        message: "Something Wrong, unexpected behaviour.",
      );
}
