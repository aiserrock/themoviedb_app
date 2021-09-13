import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/domain/entities/popular_movie_response.dart';

class MovieRemoteRepositoryImpl {
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
    print('');
    return result;
  }
}
