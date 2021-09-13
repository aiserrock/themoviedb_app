import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'popular_movie_response.g.dart';
/// In this annotation need turn on flag explicitToJson because we have custom class named (Movie) inside current POJO
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  PopularMovieResponse({
    required this.page,
    required this.movies,
    required this.totalResults,
    required this.totalPages,
  });

  factory PopularMovieResponse.fromJson(Map<String,dynamic> json) => _$PopularMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);
}
