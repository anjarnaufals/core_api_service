import 'dart:io';

///[HttpServiceOverrides]
/// use this to solve bad certificate, usually endpoint not use ssl.
/// development only, dont use on production.

class HttpServiceOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
