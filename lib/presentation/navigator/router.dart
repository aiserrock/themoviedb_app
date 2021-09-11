import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entities/auth_model.dart';
import 'package:themoviedb/data/helpers/universal_inherits.dart';
import 'package:themoviedb/presentation/pages/auth_page/auth.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/movie_details.dart';
import 'package:themoviedb/presentation/pages/movie_list_page/movie_list.dart';
import 'package:themoviedb/root_navigation.dart';

class Routs {
  static const AUTH = 'auth_page';
  static const ROOT = '/';
  static const MOVIE_DETAIL = '/movie_list_page/movie_detail_page';
  static const MOVIE_LIST = '/movie_list_page';

  static String initialRoute(bool isAuth) => isAuth ? Routs.ROOT : Routs.AUTH;
}

/// Роуты, в которые не нужно передавать данные, они основаны на DI
final routes = <String, WidgetBuilder>{
  Routs.ROOT: (_) => RootNavigation(),
  Routs.AUTH: (_) => NotifierProvider(model: AuthModel(), child: Auth()),
  Routs.MOVIE_LIST: (_) => MovieList(),
};

/// Роуты, в которые необходимо передавать данные.
/// Каждый MaterialPageRoute должен содержать параметр [settings], определяющий
/// его назначение.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routs.MOVIE_DETAIL:
      final arguments = settings.arguments;
      return MaterialPageRoute(
        builder: (_) {
          if (arguments is int) {
            return MovieDetails(movieId: arguments);
          }
          return MovieDetails(movieId: 0);
        },
        settings: settings,
      );
    default:
      throw Exception("Route with name ${settings.name} doesn't exists");
  }
}
