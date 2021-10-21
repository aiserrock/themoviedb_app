import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/data/helpers/data_providers/session_data_provider.dart';
import 'package:themoviedb/data/repositories/movie_remote_repository.dart';
import 'package:themoviedb/domain/entities/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _repository = MovieRemoteRepositoryImpl();
  final int movieId;
  bool _isFavorite = false;
  MovieDetails? _movieDetails;
  String _locale = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  MovieDetails? get movieDetails => _movieDetails;

  bool get isFavorite => _isFavorite;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      _movieDetails = await _repository.movieDetails(movieId: movieId, locale: _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _repository.isFavorite(movieId, sessionId);
      }
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();

    try {
      await _repository.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: MediaType.Movie,
        mediaId: movieId,
        isFavorite: _isFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> _handleApiClientException(ApiClientException exeption) async {
    switch (exeption.type) {
      case ApiClientExceptionType.SessionExpired:
        await onSessionExpired?.call();
        break;
      default:
        print(exeption);
    }
  }
}
