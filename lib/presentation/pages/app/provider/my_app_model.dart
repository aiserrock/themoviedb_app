import 'package:themoviedb/data/helpers/data_providers/session_data_provider.dart';

/// Класс предназначен для проверки аутентификации
class MyAppModel{
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }
}