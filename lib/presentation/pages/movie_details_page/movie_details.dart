import 'package:flutter/material.dart';
import 'package:themoviedb/data/helpers/custom_provider.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/movie_details_main_info.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/movie_details_main_screen_cast_widget.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/provider/movie_details_model.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    Key? key,
  }) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _TitleWidget(),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 21, 27, 1),
        child: ListView(
          children: [
            MovieDetailsMainInfoWidget(),
            SizedBox(
              height: 30,
            ),
            MovieDetailsMainScreenCastWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // change locale if locale was changed
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }
}

/// делаем это для того, чтобы не перезагружался весь экран, когда моделька
/// меняется. Таким образом будет перезагружатсья только текст
class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(model?.movieDetails?.title ?? 'Loading...');
  }
}

