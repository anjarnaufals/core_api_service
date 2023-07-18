library core_api_service;

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'core_base_service.dart';
import 'core_error_type.dart';
import 'core_error_response.dart';
import 'core_api_service_exception.dart';

part 'core_custom_interceptors.dart';
part 'core_operation.dart';

const Duration kconnectTimeout = Duration(milliseconds: 10000);
const Duration kreceiveTimeout = Duration(milliseconds: 5000);

/// [ApiServices]
/// To start using [ApiServices], you have to call ApiServices().initialize in main() function
///  before runApp() function.
class ApiServices with BaseService {
  ApiServices({
    required String baseUrl,
    required Map<String, dynamic> acceptHeaders,
    required Map<String, dynamic> bodyHeaders,
  }) {
    _baseUrl = baseUrl;
    _acceptHeaders = acceptHeaders;
    _bodyHeaders = bodyHeaders;
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: kconnectTimeout,
        receiveTimeout: kreceiveTimeout,
        headers: acceptHeaders,
      ),
    );
  }

  String _baseUrl = '';
  Map<String, dynamic> _bodyHeaders = {};
  Map<String, dynamic> _acceptHeaders = {};

  late final Dio _dio;
  String get baseUrl => _baseUrl;
  Map<String, dynamic> get bodyHeaders => _bodyHeaders;
  Map<String, dynamic> get acceptHeaders => _acceptHeaders;

  void updateHeaders(Map<String, dynamic> headers) {
    for (var e in headers.entries) {
      bodyHeaders[e.key] = e.value;
    }
  }

  @override
  Future get(
    String url, {
    query,
    showLog = false,
    retries = 3,
  }) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors
        .add(RetryInterceptor(dio: _dio, retries: retries, logPrint: log));

    final options = Options(headers: bodyHeaders);

    return _constructDio(
      _dio.get(url, options: options, queryParameters: query),
    );
  }

  @override
  Future post(
    String url,
    Map<String, dynamic>? data, {
    showLog = false,
  }) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: bodyHeaders);

    return _constructDio(_dio.post(url, options: options, data: data));
  }

  @override
  Future delete(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
    data,
  }) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: bodyHeaders);

    return _constructDio(
      _dio.delete(url, options: options, queryParameters: query, data: data),
    );
  }

  @override
  Future put(
    String url,
    Map<String, dynamic>? data, {
    showLog = false,
  }) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: bodyHeaders);

    return _constructDio(_dio.put(url, options: options, data: data));
  }

  @override
  Future postFormData(
    String url,
    FormData? data, {
    showLog = false,
  }) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: bodyHeaders);

    return _constructDio(_dio.post(url, options: options, data: data));
  }

  void _initializedCheck() {
    if (baseUrl.isEmpty) {
      throw ApiServiceException('Base Url Undefined !.');
    }
    if (acceptHeaders.isEmpty) {
      throw ApiServiceException('Accept Headers Undefined !.');
    }
    if (bodyHeaders.isEmpty) {
      throw ApiServiceException('Body Headers Undefined !.');
    }
  }
}
