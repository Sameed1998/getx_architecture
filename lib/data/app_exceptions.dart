class AppException implements Exception {
  final String? message;
  final String prefix;

  AppException([this.message, this.prefix = '']);

  @override
  String toString() {
    return '$prefix${message ?? "An error occurred"}';
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message ?? "No internet connection", 'Internet Exception: ');
}

class RequestTimeoutException extends AppException {
  RequestTimeoutException([String? message]) : super(message ?? "Request timed out", 'Request Timeout: ');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message ?? "Internal server error", 'Internal Server Error: ');
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super(message ?? "Invalid URL", 'Invalid URL: ');
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message ?? "Error fetching data", 'Fetch Data Error: ');
}
