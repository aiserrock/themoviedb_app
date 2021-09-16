import 'package:themoviedb/domain/entities/movie_details.dart';
import 'package:themoviedb/domain/entities/popular_movie_response.dart';

/// Абстрактный класс репозитория, который позволяет
/// получать фильмы с сервера.
abstract class MovieRemoteRepository{

  Future<PopularMovieResponse> popularMovie({
    required int page,
    required String locale,
  });

  Future<PopularMovieResponse> searchMovie({
    required int page,
    required String locale,
    required String query,
  });

  Future<MovieDetails> movieDetails({
    required int movieId,
    required String locale,
  });
}