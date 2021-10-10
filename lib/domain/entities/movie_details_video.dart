import 'package:json_annotation/json_annotation.dart';

part 'movie_details_video.g.dart';

/// for generate this big POJO i use https://javiercbk.github.io/json_to_dart/ or Json2Dart plugin
/// api for this POJO: https://developers.themoviedb.org/3/movies/get-movie-videos
/// In api fields in snake_case? but in my program fields in camelCase
/// I solved this problem using annotation below
/// In this annotation need turn on flag explicitToJson because we have custom class named (Movie) inside current POJO
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideo {
  final List<MovieDetailsVideoResults> results;

  MovieDetailsVideo({
    required this.results,
  });

  factory MovieDetailsVideo.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsVideoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideoResults {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  MovieDetailsVideoResults({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory MovieDetailsVideoResults.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideoResultsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsVideoResultsToJson(this);
}
