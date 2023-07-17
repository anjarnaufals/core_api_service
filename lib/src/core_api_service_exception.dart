class ApiServiceException implements Exception {
  final String message;
  ApiServiceException(this.message);

  @override
  String toString() {
    return 'Api Service Exception : "$message"';
  }
}
