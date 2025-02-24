class RequestRes {
  dynamic response;
  ErrorRes? error;

  RequestRes({this.response, this.error});

  bool hasError() => error != null;

  @override
  String toString() {
    return {
      "response": response,
      "error": error,
    }.toString();
  }
}

class ErrorRes {
  String message;
  dynamic code;
  dynamic data;

  ErrorRes({
    required this.message,
    this.data,
    this.code,
  });

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "data": data,
      };

  @override
  String toString() {
    return {"message": message, "code": code, "data": data}.toString();
  }
}
