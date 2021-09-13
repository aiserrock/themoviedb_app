import 'package:json_annotation/json_annotation.dart';

import 'converters/movie_dara_converter.dart';

part 'movie_details.g.dart';

/// for generate this big POJO i use https://javiercbk.github.io/json_to_dart/ or Json2Dart plugin
/// api for this POJO: https://developers.themoviedb.org/3/movies/get-movie-details
/// In api fields in snake_case? but in my program fields in camelCase
/// I solved this problem using annotation below
/// In this annotation need turn on flag explicitToJson because we have custom class named (Movie) inside current POJO
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  @JsonKey(fromJson: convertDateFromString)
  final DateTime? releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetails(
      {required this.adult,
      this.backdropPath,
      this.belongsToCollection,
      required this.budget,
      required this.genres,
      this.homepage,
      required this.id,
      this.imdbId,
      required this.originalLanguage,
      required this.originalTitle,
      this.overview,
      required this.popularity,
      this.posterPath,
      required this.productionCompanies,
      required this.productionCountries,
      required this.releaseDate,
      required this.revenue,
      this.runtime,
      required this.spokenLanguages,
      required this.status,
      this.tagline,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BelongsToCollection {
  const BelongsToCollection();

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genres {
  final int id;
  final String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanies {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompanies(
      {required this.id,
      this.logoPath,
      required this.name,
      required this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;

  ProductionCountries({required this.iso, required this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguages {
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;

  SpokenLanguages({required this.iso, required this.name});

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);
}
