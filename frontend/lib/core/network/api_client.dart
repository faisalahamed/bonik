import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiClient {
  const ApiClient({
    this.connectionTimeout = const Duration(seconds: 2),
    this.requestTimeout = const Duration(seconds: 6),
    this.authTokenProvider,
  });

  final Duration connectionTimeout;
  final Duration requestTimeout;
  final FutureOr<String?> Function()? authTokenProvider;

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
          .post(uri, headers: await _jsonHeaders(), body: jsonEncode(body))
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
          .get(uri, headers: await _acceptJsonHeaders())
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

  Future<Map<String, String>> _acceptJsonHeaders() async {
    return {
      'Accept': 'application/json',
      if (await _authToken() case final token?)
        'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, String>> _jsonHeaders() async {
    return {...await _acceptJsonHeaders(), 'Content-Type': 'application/json'};
  }

  Future<String?> _authToken() async {
    final token = await authTokenProvider?.call();
    final trimmed = token?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

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
