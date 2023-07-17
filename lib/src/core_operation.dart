part of 'core_api_services_base.dart';

Future<void> _constructDio(Future<Response> future) async {
  dynamic responseJson;
  try {
    await future.then(
      (res) => responseJson = _filterResponse(res.data, res.statusCode),
    );
  } on DioException catch (e) {
    _dioErrorThrow(e);
  } on SocketException {
    throw _errorException(CoreErrorType.noConnection);
  }

  return responseJson;
}

Future<dynamic> _filterResponse(dynamic json, int? statusCode) async {
  if (statusCode == 200) {
    return json;
  } else {
    throw json;
  }
}

_dioErrorThrow(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw _errorException(CoreErrorType.requestTimeOut);
    case DioExceptionType.sendTimeout:
      throw _errorException(CoreErrorType.requestTimeOut);
    default:
      throw _errorException(e.response?.data);
  }
}

_errorException(dynamic error) {
  if (error != null) {
    if (error is CoreErrorResponse) {
      CoreErrorResponse err = error;

      return err;
    }
    if (error is Map<String, dynamic>) {
      CoreErrorResponse err = CoreErrorResponse.fromJson(error);

      // RegExp regExp = RegExp(r'"code":(\d+),\s*"message":"(.+?)"');

      // Match? match = regExp.firstMatch(somethingError);

      // if (match != null) {
      //   String code = match.group(1)!;
      //   String message = match.group(2)!;

      //   return "Code: $code , Message: $message";
      // } else {
      //   return error;
      // }

      return err.code != null ? err : error;
    }
    if (error is String) {
      return error;
    }
  } else {
    // return error;
    // usually if the server response is null
    // throw everything error use Exception Object
    return ApiServiceException(
      "Server Error | Error URL Endpoint | Null Response",
    );
  }
}
