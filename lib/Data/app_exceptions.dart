class AppException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message;
  // ignore: prefer_typing_uninitialized_variables
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error Druing Communication");
}

class BadExceptionRequest extends AppException {
  BadExceptionRequest([String? message]) : super(message, "Inavlid Request");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, "Invalid Input Request");
}

class UnauthorisedRequest extends AppException {
  UnauthorisedRequest([String? message])
      : super(message, "Unautherized Request");
}
