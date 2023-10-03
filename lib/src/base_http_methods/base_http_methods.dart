mixin BaseHttpMethods {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
  });
  Future<dynamic> post<T>(
    String url,
    T? data, {
    showLog = false,
  });
  Future<dynamic> put<T>(
    String url,
    T? data, {
    showLog = false,
  });
  Future<dynamic> delete<T>(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
    T? data,
  });
}
