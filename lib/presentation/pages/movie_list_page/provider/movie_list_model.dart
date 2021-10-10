import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/data/repositories/movie_remote_repository.dart';
import 'package:themoviedb/domain/entities/movie.dart';
import 'package:themoviedb/domain/entities/popular_movie_response.dart';
import 'package:themoviedb/presentation/navigator/router.dart';

class MovieListModel extends ChangeNotifier {
  /// в миллисекундах
  static const TIMEOUT_SEARCH = 250;
  final _repository = MovieRemoteRepositoryImpl();
  final _movies = <Movie>[];
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String? _searchQuery;
  String _locale = '';
  /// Optimization search query
  Timer? searchDebounce;

  List<Movie> get movies => List.unmodifiable(_movies);

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(Routs.MOVIE_DETAIL, arguments: id);
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale) async {
    final query = _searchQuery;
    if (query == null) {
      return await _repository.popularMovie(page: nextPage, locale: _locale);
    } else {
      return await _repository.searchMovie(
          page: nextPage, locale: _locale, query: query);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final moviesResponse = await _loadMovies(nextPage, _locale);
      _movies.addAll(moviesResponse.movies);

      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
      // need add snack
    }
  }

  /// метод отвечающий за поиск, применяется таймер
  /// для оптимизации использовнаия трафика
  Future<void> searchMovie(String text) async {
    /// экономия трафика и убираем моргание экрана
    /// мы отложили запросы пользователя на 1 сек
    /// их может быть очень много и они выстраиваюстяя в очередь
    /// после задержки выполняются поочереди
    /// searchDebounce?.cancel() отменяет предыдущий таймер
    /// в итоге остается только один таймер с нужным нам значением который выполнит
    /// поисковой запрос через 1 секунду
    /// ровно1  запрос а не много!
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds:TIMEOUT_SEARCH),() async{
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      await _resetList();
    });
  }

  /// endless movie upload
  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }
}
