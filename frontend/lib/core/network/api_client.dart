import 'dart:convert';
import 'dart:io';

import '../config/app_config.dart';

class ApiClient {
  const ApiClient();

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
    final uri = Uri.parse('$baseUrl$path');

    try {
      final request = await client.postUrl(uri);
      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      request.write(jsonEncode(body));

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
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
