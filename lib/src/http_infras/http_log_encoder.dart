import 'dart:convert';
import 'dart:developer';

class HttpLogEncoder {
  static JsonDecoder decoder = const JsonDecoder();
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static prettyLogJson(String input) {
    var object = decoder.convert(input);
    var prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((element) => log(element));
  }
}
