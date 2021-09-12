import 'package:flutter/cupertino.dart';
import 'package:pedantic/pedantic.dart';
import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/data/helpers/data_providers/session_data_provider.dart';
import 'package:themoviedb/data/repositories/user_remote_repository.dart';
import 'package:themoviedb/presentation/navigator/router.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = UserRemoteRepositoryImpl();
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;

  bool get isAuthProgress => _isAuthProgress;

  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Fill login and password';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMessage = 'Server not allow. Check internet connection';
          break;
        case ApiClientExceptionType.Auth:
          _errorMessage = 'Login or password incorrect';
          break;
        case ApiClientExceptionType.Other:
          _errorMessage = 'Unknown error. Pleas repeat your attempt';
          break;
      }
    } catch (e) {
      _errorMessage = 'Unknown error';
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Unknown error, pleas repeat attempt';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context).popAndPushNamed(Routs.ROOT));
  }
}
