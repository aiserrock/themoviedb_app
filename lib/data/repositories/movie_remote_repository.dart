import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/domain/entities/movie_details.dart';
import 'package:themoviedb/domain/entities/popular_movie_response.dart';
import 'package:themoviedb/domain/repositories/movie_remote_repository.dart';

/// API 1 movies : https://developers.themoviedb.org/3/movies/get-movie-details
///     2 check favorite movies (need session id) : https://developers.themoviedb.org/3/account/get-favorite-movies
///
///
enum MediaType { Movie, TV }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.Movie:
        return 'movie';
      case MediaType.TV:
        return 'tv';
    }
  }
}

class MovieRemoteRepositoryImpl implements MovieRemoteRepository {
  final clientHelper = ApiClient();

  /// https://developers.themoviedb.org/3/movies/get-popular-movies
  Future<PopularMovieResponse> popularMovie({
    required int page,
    required String locale,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = clientHelper.get(
      'movie/popular',
      parser,
      <String, dynamic>{
        'api_key': ApiClient.apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  /// https://developers.themoviedb.org/3/search/search-movies
  Future<PopularMovieResponse> searchMovie({
    required int page,
    required String locale,
    required String query,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = clientHelper.get(
      'search/movie',
      parser,
      <String, dynamic>{
        'api_key': ApiClient.apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  /// https://developers.themoviedb.org/3/movies/get-movie-details
  Future<MovieDetails> movieDetails({
    required int movieId,
    required String locale,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    };
    final result = clientHelper.get(
      'movie/$movieId',
      parser,
      <String, dynamic>{
        'append_to_response': 'credits,videos',
        'api_key': ApiClient.apiKey,
        'language': locale,
      },
    );
    return result;
  }

  /// https://developers.themoviedb.org/3/movies/get-movie-account-states
  Future<bool> isFavorite(
    int movieId,
    String sessionId,
  ) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;
      return result;
    };
    final result = clientHelper.get(
      'movie/$movieId/account_states',
      parser,
      <String, dynamic>{
        'api_key': ApiClient.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  /// https://developers.themoviedb.org/3/account/mark-as-favorite
  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId.toString(),
      'favorite': isFavorite.toString(),
    };
    final parser = (dynamic json) {
      return 1;
    };
    final result = clientHelper.post(
      '/account/$accountId/favorite',
      parser,
      parameters,
      <String, dynamic>{
        'api_key': ApiClient.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
