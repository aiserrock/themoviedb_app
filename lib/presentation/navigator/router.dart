import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/pages/auth_page/provider/auth_model.dart';
import 'package:themoviedb/presentation/pages/movie_trailer_page/screens/movei_trailer.dart';
import 'package:themoviedb/presentation/pages/news_page/screens/news.dart';
import 'package:themoviedb/presentation/pages/tw_shows_page/screens/tw_shows.dart';
import 'package:themoviedb/data/helpers/custom_provider.dart';
import 'package:themoviedb/presentation/pages/auth_page/screens/auth.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/screens/movie_details.dart';
import 'package:themoviedb/presentation/pages/movie_list_page/screens/movie_list.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/provider/movie_details_model.dart';
import 'package:themoviedb/presentation/pages/app/screens/root_navigation.dart';

class Routs {
  static const AUTH = 'auth_page';
  static const ROOT = '/';
  static const MOVIE_DETAIL = '/movie_list_page/movie_detail_page';
  static const MOVIE_LIST = '/movie_list_page';
  static const NEWS = '/news';
  static const TW_SHOWS = '/tw_shows';
  static const MOVIE_TRAILER = '/movie_details/trailer';

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
    case Routs.MOVIE_TRAILER:
      final arguments = settings.arguments;
      final youtubeKey = arguments is String ? arguments : '';
      return MaterialPageRoute(
        builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey),
      );
    default:
      throw Exception("Route with name ${settings.name} doesn't exists");
  }
}
