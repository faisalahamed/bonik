import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiClient {
  const ApiClient({
    this.connectionTimeout = const Duration(seconds: 2),
    this.requestTimeout = const Duration(seconds: 6),
  });

  final Duration connectionTimeout;
  final Duration requestTimeout;

  String get baseUrl {
    if (!kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android &&
        AppConfig.apiBaseUrl.startsWith('http://127.0.0.1')) {
      return AppConfig.apiBaseUrl.replaceFirst('127.0.0.1', '10.0.2.2');
    }

    if (!kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android &&
        AppConfig.apiBaseUrl.startsWith('http://localhost')) {
      return AppConfig.apiBaseUrl.replaceFirst('localhost', '10.0.2.2');
    }

    return AppConfig.apiBaseUrl;
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    try {
      final response = await http
          .post(uri, headers: _jsonHeaders, body: jsonEncode(body))
          .timeout(requestTimeout);
      final decoded = _decodeResponse(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          decoded['message']?.toString() ?? 'Request failed.',
          statusCode: response.statusCode,
        );
      }

      return decoded;
    } on TimeoutException {
      throw const ApiException('Could not connect to the server.');
    } on FormatException {
      throw const ApiException('Server returned an invalid response.');
    } on http.ClientException {
      throw const ApiException('Could not connect to the server.');
    }
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String> queryParameters = const {},
  }) async {
    final baseUri = Uri.parse('$baseUrl$path');
    final uri = baseUri.replace(
      queryParameters: {...baseUri.queryParameters, ...queryParameters},
    );

    try {
      final response = await http
          .get(uri, headers: _acceptJsonHeaders)
          .timeout(requestTimeout);
      final decoded = _decodeResponse(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          decoded['message']?.toString() ?? 'Request failed.',
          statusCode: response.statusCode,
        );
      }

      return decoded;
    } on TimeoutException {
      throw const ApiException('Could not connect to the server.');
    } on FormatException {
      throw const ApiException('Server returned an invalid response.');
    } on http.ClientException {
      throw const ApiException('Could not connect to the server.');
    }
  }

  static const Map<String, String> _acceptJsonHeaders = {
    'Accept': 'application/json',
  };

  static const Map<String, String> _jsonHeaders = {
    ..._acceptJsonHeaders,
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> _decodeResponse(String responseBody) {
    if (responseBody.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(responseBody);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw const FormatException('Response was not a JSON object.');
  }
}

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}
