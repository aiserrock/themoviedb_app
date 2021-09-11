import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/repositories/user_remote_repository.dart';

/// 1.Expected errors
/// 2.No internet connection
///
/// 3.Server not response, timeout
/// 4.Server unavailable
/// 5.Server cannot process the requested request
///
/// 6.Server send error (expected)

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class UserRemoteRepositoryImpl extends UserRemoteRepository {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3/';

  // static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '73024877558036b4787e808716039caf';

  @override
  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> _makeToken() async {
    final url = _makeUri(
      'authentication/token/new',
      <String, dynamic>{'api_key': _apiKey},
    );
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode()) as Map<String, dynamic>;

      if (response.statusCode == 401) {
        final dynamic status = json['status_code'];
        final code = status is int ? status : 0;
        if (code == 30) {
          throw ApiClientException(ApiClientExceptionType.Auth);
        } else {
          throw ApiClientException(ApiClientExceptionType.Other);
        }
      }

      final token = json['request_token'] as String;
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final url = _makeUri(
      'authentication/token/validate_with_login',
      <String, dynamic>{'api_key': _apiKey},
    );
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };

    try {
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(parameters));
      final response = await request.close();
      final json = (await response.jsonDecode()) as Map<String, dynamic>;

      if (response.statusCode == 401) {
        final dynamic status = json['status_code'];
        final code = status is int ? status : 0;
        if (code == 30) {
          throw ApiClientException(ApiClientExceptionType.Auth);
        } else {
          throw ApiClientException(ApiClientExceptionType.Other);
        }
      }

      final token = json['request_token'] as String;
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final url = _makeUri(
      'authentication/session/new',
      <String, dynamic>{'api_key': _apiKey},
    );
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };

    try {
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(parameters));
      final response = await request.close();
      final json = (await response.jsonDecode()) as Map<String, dynamic>;

      if(response.statusCode == 401){
        final dynamic status = json['status_code'];
        final code = status is int? status : 0;
        if(code == 30){
          throw ApiClientException(ApiClientExceptionType.Auth);
        } else{
          throw ApiClientException(ApiClientExceptionType.Other);
        }
      }

      final sessionId = json['session_id'] as String;
      return sessionId;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
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
