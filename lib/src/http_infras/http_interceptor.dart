import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;

class HttpInterceptor extends http.BaseClient {
  final http.Client _inner;

  HttpInterceptor(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    log('REQUEST[${request.method}] => PATH:  ${request.url}');

    return await _inner.send(request);
  }
}
