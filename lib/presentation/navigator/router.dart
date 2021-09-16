import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/pages/news_page/news.dart';
import 'package:themoviedb/presentation/pages/tw_shows_page/tw_shows.dart';
import 'package:themoviedb/presentation/widgets/auth_page/provider/auth_model.dart';
import 'package:themoviedb/data/helpers/custom_provider.dart';
import 'package:themoviedb/presentation/pages/auth_page/auth.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/movie_details.dart';
import 'package:themoviedb/presentation/pages/movie_list_page/movie_list.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/provider/movie_details_model.dart';
import 'package:themoviedb/root_navigation.dart';

class Routs {
  static const AUTH = 'auth_page';
  static const ROOT = '/';
  static const MOVIE_DETAIL = '/movie_list_page/movie_detail_page';
  static const MOVIE_LIST = '/movie_list_page';
  static const NEWS ='/news';
  static const TW_SHOWS ='/tw_shows';

  static String initialRoute(bool isAuth) => isAuth ? Routs.ROOT : Routs.AUTH;
}

/// Роуты, в которые не нужно передавать данные, они основаны на DI
final routes = <String, WidgetBuilder>{
  Routs.ROOT: (_) => RootNavigation(),
  Routs.AUTH: (_) => NotifierProvider(create: () => AuthModel(), child: Auth()),
  Routs.MOVIE_LIST: (_) => MovieList(),
  Routs.NEWS: (_) => News(),
  Routs.TW_SHOWS: (_) => TwShows(),
};

/// Роуты, в которые необходимо передавать данные.
/// Каждый MaterialPageRoute должен содержать параметр [settings], определяющий
/// его назначение.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routs.MOVIE_DETAIL:
      final arguments = settings.arguments;
      final movieId = arguments is int ? arguments : 0;
      return MaterialPageRoute(
        builder: (context) => NotifierProvider(
          create: () => MovieDetailsModel(movieId),
          child: const MovieDetails(),
        ),
      );
    default:
      throw Exception("Route with name ${settings.name} doesn't exists");
  }
}
