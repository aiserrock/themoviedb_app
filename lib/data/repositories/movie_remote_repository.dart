import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/domain/entities/movie_details.dart';
import 'package:themoviedb/domain/entities/popular_movie_response.dart';
import 'package:themoviedb/domain/repositories/movie_remote_repository.dart';
/// API 1 movies : https://developers.themoviedb.org/3/movies/get-movie-details
///     2 check favorite movies (need session id) : https://developers.themoviedb.org/3/account/get-favorite-movies
///
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
  Future<String> markAsFavorite({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = clientHelper.post(
      'authentication/token/validate_with_login',
      parser,
      parameters,
      <String, dynamic>{'api_key': ApiClient.apiKey},
    );
    return result;
  }
}
