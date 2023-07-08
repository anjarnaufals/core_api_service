// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorRealtimeWeather {
  Error? error;
  ErrorRealtimeWeather({
    this.error,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error?.toMap(),
    };
  }

  factory ErrorRealtimeWeather.fromMap(Map<String, dynamic> map) {
    return ErrorRealtimeWeather(
      error: map['error'] != null
          ? Error.fromMap(map['error'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorRealtimeWeather.fromJson(String source) =>
      ErrorRealtimeWeather.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Error {
  int? code;
  String? message;
  Error({
    this.code,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
    };
  }

  factory Error.fromMap(Map<String, dynamic> map) {
    return Error(
      code: map['code'] != null ? map['code'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Error.fromJson(String source) =>
      Error.fromMap(json.decode(source) as Map<String, dynamic>);
}
