import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/data/repositories/movie_remote_repository.dart';
import 'package:themoviedb/domain/entities/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _repository = MovieRemoteRepositoryImpl();
  final int movieId;
  MovieDetails? _movieDetails;
  String _locale ='';
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context)async{
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails =
        await _repository.movieDetails(movieId: movieId, locale: _locale);
    notifyListeners();
  }
}
