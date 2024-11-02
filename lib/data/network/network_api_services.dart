import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getx_mvvm/data/app_exceptions.dart';
import 'package:getx_mvvm/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  static const _timeoutDuration = Duration(seconds: 10);

  @override
  Future<dynamic> getApi(String url) async {
    _logDebugInfo(url: url);

    try {
      final response = await http.get(Uri.parse(url)).timeout(_timeoutDuration);
      return _handleResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeoutException {
      throw RequestTimeoutException();
    }
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    _logDebugInfo(url: url, data: data);

    try {
      final response = await http.post(Uri.parse(url), body: data).timeout(_timeoutDuration);
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("Internet not available");
    } on RequestTimeoutException {
      throw RequestTimeoutException();
    }
  }

  Future<dynamic> putApi(dynamic data, String url) async {
    _logDebugInfo(url: url, data: data);

    try {
      final response = await http.put(Uri.parse(url), body: data).timeout(_timeoutDuration);
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("");
    } on RequestTimeoutException {
      throw RequestTimeoutException();
    }
  }

  Future<dynamic> deleteApi(String url) async {
    _logDebugInfo(url: url);

    try {
      final response = await http.delete(Uri.parse(url)).timeout(_timeoutDuration);
      return _handleResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeoutException {
      throw RequestTimeoutException();
    }
  }

dynamic _handleResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);
    case 400:
      // Attempt to decode the error message from the response body
      String errorMessage;
      try {
        final errorResponse = jsonDecode(response.body);
        errorMessage = errorResponse['message'] ?? "Invalid response"; // Adjust based on your API's error format
      } catch (e) {
        errorMessage = "Invalid response"; // Fallback message if decoding fails
      }
      throw InvalidUrlException(errorMessage);
    default:
      throw FetchDataException(
          "Error communicating with server, status code: ${response.statusCode}");
  }
}
  void _logDebugInfo({String? url, dynamic data}) {
    if (kDebugMode) {
      print("URL: $url");
      if (data != null) print("Data: $data");
    }
  }
}

