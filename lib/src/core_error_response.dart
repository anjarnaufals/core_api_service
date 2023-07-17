import 'dart:ffi';

/// [CoreErrorResponse]
/// the simply common error http response model.
///
/// {
///
///   "status": "error",
///
///   "code": 404,
///
///   "message": "Resource not found",
///
///   "data": null
///
/// }
class CoreErrorResponse {
  String? status;
  int? code;
  String? message;
  Void? data;

  CoreErrorResponse({this.status, this.code, this.message, this.data});

  CoreErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data;

    return data;
  }
}
