class UpdateProfileResponse {
  UpdateProfileResponse({
    this.message,
    this.error,
    this.statusCode,
  });

  String? message;
  String? error;
  int? statusCode;

  UpdateProfileResponse.fromJson(dynamic json) {
    var rawMessage = json['message'];

    if (rawMessage is List) {
      message = rawMessage.join(' - ');
    } else if (rawMessage is String) {
      message = rawMessage;
    } else {
      message = null;
    }

    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    map['statusCode'] = statusCode;
    return map;
  }
}