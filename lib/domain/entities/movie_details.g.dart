// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetails _$MovieDetailsFromJson(Map<String, dynamic> json) {
  return MovieDetails(
    adult: json['adult'] as bool,
    backdropPath: json['backdrop_path'] as String?,
    belongsToCollection: json['belongs_to_collection'] == null
        ? null
        : BelongsToCollection.fromJson(
            json['belongs_to_collection'] as Map<String, dynamic>),
    budget: json['budget'] as int,
    genres: (json['genres'] as List<dynamic>)
        .map((e) => Genres.fromJson(e as Map<String, dynamic>))
        .toList(),
    homepage: json['homepage'] as String?,
    id: json['id'] as int,
    imdbId: json['imdb_id'] as String?,
    originalLanguage: json['original_language'] as String,
    originalTitle: json['original_title'] as String,
    overview: json['overview'] as String?,
    popularity: (json['popularity'] as num).toDouble(),
    posterPath: json['poster_path'] as String?,
    productionCompanies: (json['production_companies'] as List<dynamic>)
        .map((e) => ProductionCompanies.fromJson(e as Map<String, dynamic>))
        .toList(),
    productionCountries: (json['production_countries'] as List<dynamic>)
        .map((e) => ProductionCountries.fromJson(e as Map<String, dynamic>))
        .toList(),
    releaseDate: convertDateFromString(json['release_date'] as String?),
    revenue: json['revenue'] as int,
    runtime: json['runtime'] as int?,
    spokenLanguages: (json['spoken_languages'] as List<dynamic>)
        .map((e) => SpokenLanguages.fromJson(e as Map<String, dynamic>))
        .toList(),
    status: json['status'] as String,
    tagline: json['tagline'] as String?,
    title: json['title'] as String,
    video: json['video'] as bool,
    voteAverage: (json['vote_average'] as num).toDouble(),
    voteCount: json['vote_count'] as int,
    credits:
        MovieDetailsCredits.fromJson(json['credits'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MovieDetailsToJson(MovieDetails instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'belongs_to_collection': instance.belongsToCollection?.toJson(),
      'budget': instance.budget,
      'genres': instance.genres.map((e) => e.toJson()).toList(),
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'production_companies':
          instance.productionCompanies.map((e) => e.toJson()).toList(),
      'production_countries':
          instance.productionCountries.map((e) => e.toJson()).toList(),
      'release_date': instance.releaseDate?.toIso8601String(),
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spoken_languages':
          instance.spokenLanguages.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'credits': instance.credits.toJson(),
    };

BelongsToCollection _$BelongsToCollectionFromJson(Map<String, dynamic> json) {
  return BelongsToCollection();
}

Map<String, dynamic> _$BelongsToCollectionToJson(
        BelongsToCollection instance) =>
    <String, dynamic>{};

Genres _$GenresFromJson(Map<String, dynamic> json) {
  return Genres(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductionCompanies _$ProductionCompaniesFromJson(Map<String, dynamic> json) {
  return ProductionCompanies(
    id: json['id'] as int,
    logoPath: json['logo_path'] as String?,
    name: json['name'] as String,
    originCountry: json['origin_country'] as String,
  );
}

Map<String, dynamic> _$ProductionCompaniesToJson(
        ProductionCompanies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

ProductionCountries _$ProductionCountriesFromJson(Map<String, dynamic> json) {
  return ProductionCountries(
    iso: json['iso_3166_1'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ProductionCountriesToJson(
        ProductionCountries instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso,
      'name': instance.name,
    };

SpokenLanguages _$SpokenLanguagesFromJson(Map<String, dynamic> json) {
  return SpokenLanguages(
    iso: json['iso_639_1'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$SpokenLanguagesToJson(SpokenLanguages instance) =>
    <String, dynamic>{
      'iso_639_1': instance.iso,
      'name': instance.name,
    };
