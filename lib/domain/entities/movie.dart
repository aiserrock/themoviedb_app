import 'package:json_annotation/json_annotation.dart';

import 'converters/movie_dara_converter.dart';

part 'movie.g.dart';

/// api for this POJO: https://developers.themoviedb.org/3/movies/get-popular-movies
/// In api fields in snake_case? but in my program fields in camelCase
/// I solved this problem using annotation below
@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  /// or you can use annotation like this for each field
  /// @JsonKey(name: 'poster_path')
  final String? posterPath;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: convertDateFromString)
  final DateTime? releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  Movie({
    this.posterPath,
    required this.adult,
    required this.overview,
    this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
