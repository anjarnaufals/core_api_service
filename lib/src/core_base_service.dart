import 'package:dio/dio.dart';

mixin BaseService {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
  });
  Future<dynamic> post(
    String url,
    Map<String, dynamic>? data, {
    showLog = false,
  });
  Future<dynamic> put(
    String url,
    Map<String, dynamic>? data, {
    showLog = false,
  });
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
  });
  Future<dynamic> postFormData(
    String url,
    FormData? data, {
    showLog = false,
  });
}
