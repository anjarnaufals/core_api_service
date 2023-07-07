library core_api_service;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'core_base_service.dart';
import 'core_error_model.dart';
import 'core_error_response.dart';
import 'core_api_service_exception.dart';

part 'core_custom_interceptors.dart';
part 'core_operation.dart';

const Duration kconnectTimeout = Duration(milliseconds: 10000);
const Duration kreceiveTimeout = Duration(milliseconds: 5000);

class ApiServices with BaseService {
  static String _baseUrl = '';
  static Map<String, dynamic> _acceptheaders = {};
  static Map<String, dynamic> _bodyHeaders = {};
  static bool _isInitialized = false;

  static Future<void> initialize({
    required String baseUrl,
    required Map<String, dynamic> acceptheaders,
    required Map<String, dynamic> bodyHeaders,
  }) async {
    _baseUrl = baseUrl;
    _acceptheaders = acceptheaders;
    _bodyHeaders = bodyHeaders;
    _isInitialized = true;
  }

  static Map<String, dynamic> get showBodyHeaders => _bodyHeaders;

  static set updateHeaders(Map<String, dynamic> headers) {
    for (var e in headers.entries) {
      _bodyHeaders[e.key] = e.value;
    }
  }

  final _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: kconnectTimeout,
      receiveTimeout: kreceiveTimeout,
      headers: _acceptheaders,
    ),
  );

  @override
  Future get(String url, {query, showLog = false, retries = 3}) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors
        .add(RetryInterceptor(dio: _dio, retries: retries, logPrint: log));

    final options = Options(headers: _bodyHeaders);

    return _constructDio(
        _dio.get(url, options: options, queryParameters: query));
  }

  @override
  Future post(String url, Map<String, dynamic>? data, {showLog = false}) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: _bodyHeaders);

    return _constructDio(_dio.post(url, options: options, data: data));
  }

  @override
  Future delete(String url,
      {Map<String, dynamic>? query, showLog = false, data}) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: _bodyHeaders);

    return _constructDio(
        _dio.delete(url, options: options, queryParameters: query, data: data));
  }

  @override
  Future put(String url, Map<String, dynamic>? data, {showLog = false}) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: _bodyHeaders);

    return _constructDio(_dio.put(url, options: options, data: data));
  }

  @override
  Future postFormData(String url, FormData? data, {showLog = false}) {
    _initializedCheck();

    if (showLog) _dio.interceptors.add(_CustomInterceptors());

    _dio.interceptors.add(RetryInterceptor(dio: _dio, logPrint: log));

    final options = Options(headers: _bodyHeaders);

    return _constructDio(_dio.post(url, options: options, data: data));
  }
}
