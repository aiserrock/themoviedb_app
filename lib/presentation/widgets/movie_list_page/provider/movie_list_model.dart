import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/data/repositories/movie_remote_repository.dart';
import 'package:themoviedb/domain/entities/movie.dart';
import 'package:themoviedb/presentation/navigator/router.dart';

class MovieListModel extends ChangeNotifier {
  String _locale = '';

  final _repository = MovieRemoteRepositoryImpl();
  final _movies = <Movie>[];
  late DateFormat _dateFormat;

  List<Movie> get movies => List.unmodifiable(_movies);

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(Routs.MOVIE_DETAIL, arguments: id);
  }

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final moviesResponse =
    await _repository.popularMovie(page: 1, locale: _locale);
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }
}
