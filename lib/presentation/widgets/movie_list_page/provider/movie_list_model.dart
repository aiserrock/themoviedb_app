import 'package:flutter/cupertino.dart';
import 'package:themoviedb/data/repositories/movie_remote_repository.dart';
import 'package:themoviedb/domain/entities/movie.dart';
import 'package:themoviedb/presentation/navigator/router.dart';

class MovieListModel extends ChangeNotifier {
  final _repository = MovieRemoteRepositoryImpl();
  final _movies = <Movie>[];

  List<Movie> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    final moviesResponse =
        await _repository.popularMovie(page: 1, locale: 'en-US');
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(Routs.MOVIE_DETAIL, arguments: id);
  }
}
