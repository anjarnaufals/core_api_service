part of 'core_api_services_base.dart';

class _CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH:  ${options.uri}');
    if (options.queryParameters.isNotEmpty) {
      log('REQUEST["QUERY"] => ${options.queryParameters}');
    }
    if (options.data != null) log('REQUEST["DATA"] => ${options.data}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}');
    log('RESPONSE[${"BODY"}] => ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    log('RESPONSE[${"BODY"}] => ${err.response}');

    return super.onError(err, handler);
  }
}
