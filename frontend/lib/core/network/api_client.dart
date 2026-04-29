import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../config/app_config.dart';

class ApiClient {
  const ApiClient({
    this.connectionTimeout = const Duration(seconds: 2),
    this.requestTimeout = const Duration(seconds: 6),
  });

  final Duration connectionTimeout;
  final Duration requestTimeout;

  String get baseUrl {
    if (Platform.isAndroid &&
        AppConfig.apiBaseUrl.startsWith('http://127.0.0.1')) {
      return AppConfig.apiBaseUrl.replaceFirst('127.0.0.1', '10.0.2.2');
    }

    if (Platform.isAndroid &&
        AppConfig.apiBaseUrl.startsWith('http://localhost')) {
      return AppConfig.apiBaseUrl.replaceFirst('localhost', '10.0.2.2');
    }

    return AppConfig.apiBaseUrl;
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final client = HttpClient();
    client.connectionTimeout = connectionTimeout;
    final uri = Uri.parse('$baseUrl$path');

    try {
      final request = await client.postUrl(uri).timeout(requestTimeout);
      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      request.write(jsonEncode(body));

      final response = await request.close().timeout(requestTimeout);
      final responseBody = await response
          .transform(utf8.decoder)
          .join()
          .timeout(requestTimeout);
      final decoded = _decodeResponse(responseBody);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          decoded['message']?.toString() ?? 'Request failed.',
          statusCode: response.statusCode,
        );
      }

      return decoded;
    } on SocketException {
      throw const ApiException('Could not connect to the server.');
    } on TimeoutException {
      throw const ApiException('Could not connect to the server.');
    } on FormatException {
      throw const ApiException('Server returned an invalid response.');
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String> queryParameters = const {},
  }) async {
    final client = HttpClient();
    client.connectionTimeout = connectionTimeout;
    final baseUri = Uri.parse('$baseUrl$path');
    final uri = baseUri.replace(
      queryParameters: {...baseUri.queryParameters, ...queryParameters},
    );

    try {
      final request = await client.getUrl(uri).timeout(requestTimeout);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      final response = await request.close().timeout(requestTimeout);
      final responseBody = await response
          .transform(utf8.decoder)
          .join()
          .timeout(requestTimeout);
      final decoded = _decodeResponse(responseBody);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          decoded['message']?.toString() ?? 'Request failed.',
          statusCode: response.statusCode,
        );
      }

      return decoded;
    } on SocketException {
      throw const ApiException('Could not connect to the server.');
    } on TimeoutException {
      throw const ApiException('Could not connect to the server.');
    } on FormatException {
      throw const ApiException('Server returned an invalid response.');
    } finally {
      client.close();
    }
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
