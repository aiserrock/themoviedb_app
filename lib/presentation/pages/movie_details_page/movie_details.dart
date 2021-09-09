import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/movie_details_main_info.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/movie_details_main_screen_cast_widget.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  MovieDetails({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minecraft Jungle'),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 21, 27, 1),
        child: ListView(
          children: [
            MovieDetailsMainInfoWidget(),
            SizedBox(height: 30,),
            MovieDetailsMainScreenCastWidget(),
          ],
        ),
      ),
    );
  }
}