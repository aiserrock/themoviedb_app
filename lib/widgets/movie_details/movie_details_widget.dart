import 'package:flutter/material.dart';

import 'movie_details_main_info.dart';
import 'movie_details_main_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;

  MovieDetailsWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
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
