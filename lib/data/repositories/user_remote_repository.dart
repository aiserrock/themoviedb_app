import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/domain/repositories/user_remote_repository.dart';
/// Errors type
/// 1.Expected errors
/// 2.No internet connection
///
/// 3.Server not response, timeout
/// 4.Server unavailable
/// 5.Server cannot process the requested request
///
/// 6.Server send error (expected)

class UserRemoteRepositoryImpl extends UserRemoteRepository {
  final clientHelper = ApiClient();

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

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = clientHelper.get(
      'authentication/token/new',
      parser,
      <String, dynamic>{'api_key': ApiClient.apiKey},
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = clientHelper.post(
      'authentication/token/validate_with_login',
      parser,
      parameters,
      <String, dynamic>{'api_key': ApiClient.apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final result = clientHelper.post(
      'authentication/session/new',
      parser,
      parameters,
      <String, dynamic>{'api_key':ApiClient.apiKey},
    );
    return result;
  }
}
