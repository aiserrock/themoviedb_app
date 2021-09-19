import 'package:flutter/material.dart';
import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/data/helpers/custom_provider.dart';
import 'package:themoviedb/presentation/general_widgets/radial_percent_widget.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/provider/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: _MovieNameWidget(),
        ),
        _ScorePlayTrailerWidget(),
        _SummaryWidget(),
        _OverviewWidget(),
        SizedBox(
          height: 30,
        ),
        _PeopleWidget(),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: model?.movieDetails?.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            TextSpan(
              text: year,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        maxLines: 3,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];

    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }

    final runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final genres = model.movieDetails?.productionCountries;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for(var genr in genres){
        genresNames.add(genr.name);
      }
      texts.add(genresNames.join(', '));
    }
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          texts.join(' '),
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Text(
         model?.movieDetails?.overview ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  _PeopleWidget({
    Key? key,
  }) : super(key: key);

  final nameStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final jobTitleStyleStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ScorePlayTrailerWidget extends StatelessWidget {
  const _ScorePlayTrailerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final voteAverage = (model?.movieDetails?.voteAverage ?? 0) * 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: RadialPercentWidget(
                  child: Text(voteAverage.toStringAsFixed(0)),
                  percent: voteAverage / 100,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  lineWidth: 3,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('User Score'),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}
