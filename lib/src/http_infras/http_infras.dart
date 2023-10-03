import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';

import '../api_exception/api_exception.dart';
import '../base_http_methods/base_http_methods.dart';
import 'http_log_encoder.dart';

class HttpInfras with BaseHttpMethods {
  HttpInfras({
    required this.baseUrl,
    this.headers,
  }) {
    _client = http.Client();
  }
  String baseUrl = '';
  Map<String, String>? headers = {};

  late final http.Client _client;

  @override
  Future<Either<ApiException, dynamic>> get(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
  }) async {
    final client = RetryClient(_client);

    var parseUri = Uri.https(baseUrl, url, query);

    return await _eitherCallHttp(
      client.get(parseUri, headers: headers),
      client,
      showLog: showLog,
    );
  }

  @override
  Future<Either<ApiException, dynamic>> delete<T>(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
    T? data,
  }) async {
    final client = RetryClient(_client);

    var parseUri = Uri.https(baseUrl, url, query);

    return await _eitherCallHttp(
      client.delete(parseUri, headers: headers, body: data),
      client,
      showLog: showLog,
    );
  }

  @override
  Future<Either<ApiException, dynamic>> post<T>(
    String url,
    T? data, {
    showLog = false,
  }) async {
    final client = RetryClient(_client);

    var parseUri = Uri.https(baseUrl, url);

    return await _eitherCallHttp(
      client.post(parseUri, headers: headers, body: data),
      client,
      showLog: showLog,
    );
  }

  @override
  Future<Either<ApiException, dynamic>> put<T>(
    String url,
    T? data, {
    showLog = false,
  }) async {
    final client = RetryClient(_client);

    var parseUri = Uri.https(baseUrl, url);

    return await _eitherCallHttp(
      client.put(parseUri, headers: headers, body: data),
      client,
      showLog: showLog,
    );
  }

  Future<Either<ApiException, dynamic>> _eitherCallHttp(
    Future<Response> future,
    RetryClient client, {
    bool showLog = false,
  }) async {
    try {
      Response? response;
      await future.then((res) {
        if (showLog) {
          log('RESPONSE[${res.statusCode}');
          HttpLogEncoder.prettyLogJson(res.body);
        }

        response = res;
      });

      return response?.statusCode == 200
          ? Right(jsonDecode(response!.body))
          : Left(ApiException(
              code: response?.statusCode,
              message: response?.reasonPhrase,
              res: jsonDecode(response!.body),
            ));
    } on SocketException catch (e) {
      return Left(ApiException(
        message: e.message,
      ));
    } on FormatException catch (e) {
      return Left(ApiException(
        message: e.message,
      ));
    } on Exception catch (e) {
      return Left(ApiException(
        message: e.toString(),
      ));
    } finally {
      client.close();
    }
  }
}
