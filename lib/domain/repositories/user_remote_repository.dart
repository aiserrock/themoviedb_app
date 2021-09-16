/// Абстрактный класс репозитория, который позволяет авторизовать
/// пользователя с использованием сервера.
abstract class UserRemoteRepository{

  /// Авторизация пользователя через удаленный сервер
  /// Возвращает session_id
  Future<String> auth({required String username,required String password});
}