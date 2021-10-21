import 'dart:convert';
import 'dart:io';

enum ApiClientExceptionType { Network, Auth, Other, SessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  static const _host = 'https://api.themoviedb.org/3/';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const apiKey = '73024877558036b4787e808716039caf';

  static String imageUrl(String path) => _imageUrl + path;

  final _client = HttpClient();

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());

      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> post<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic>? bodyParameters, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    final url = _makeUri(
      path,
      urlParameters,
    );
    try {
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      if (response.statusCode == 201) {
        return 1 as T;
      }
      final dynamic json = (await response.jsonDecode());

      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}

void _validateResponse(HttpClientResponse response, dynamic json) {
  if (response.statusCode == 401) {
    final dynamic status = json['status_code'];
    final code = status is int ? status : 0;
    if (code == 30) {
      throw ApiClientException(ApiClientExceptionType.Auth);
    } else if (code == 3) {
      throw ApiClientException(ApiClientExceptionType.SessionExpired);
    } else {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }
}
