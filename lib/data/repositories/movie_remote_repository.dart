import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/domain/entities/movie_details.dart';
import 'package:themoviedb/domain/entities/popular_movie_response.dart';
import 'package:themoviedb/domain/repositories/movie_remote_repository.dart';

class MovieRemoteRepositoryImpl implements MovieRemoteRepository {
  final clientHelper = ApiClient();

  Future<PopularMovieResponse> popularMovie({
    required int page,
    required String locale,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String,dynamic>;
      final response  = PopularMovieResponse.fromJson(jsonMap);
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

  Future<PopularMovieResponse> searchMovie({
    required int page,
    required String locale,
    required String query,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String,dynamic>;
      final response  = PopularMovieResponse.fromJson(jsonMap);
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

  Future<MovieDetails> movieDetails({
    required int movieId,
    required String locale,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String,dynamic>;
      final response  = MovieDetails.fromJson(jsonMap);
      return response;
    };
    final result = clientHelper.get(
      'movie/$movieId',
      parser,
      <String, dynamic>{
        'api_key': ApiClient.apiKey,
        'language': locale,
      },
    );
    return result;
  }
}
