import 'package:flutter/cupertino.dart';
import 'package:themoviedb/data/helpers/data_providers/session_data_provider.dart';
import 'package:themoviedb/presentation/navigator/router.dart';

/// Класс предназначен для проверки аутентификации
class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    await Navigator.of(context).pushNamedAndRemoveUntil(Routs.AUTH, (route) => false);
  }
}
