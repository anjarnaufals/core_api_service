class ApiException implements Exception {
  final int? code;
  final String? message;
  final Map<String, dynamic>? res;
  const ApiException({
    this.code,
    this.message,
    this.res,
  });
}
