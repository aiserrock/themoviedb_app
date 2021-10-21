import 'package:flutter/material.dart';
import 'package:themoviedb/data/helpers/custom_provider.dart';
import 'package:themoviedb/presentation/pages/app/provider/my_app_model.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/widgets/movie_details_main_info.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/widgets/movie_details_main_screen_cast_widget.dart';
import 'package:themoviedb/presentation/pages/movie_details_page/provider/movie_details_model.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    Key? key,
  }) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _TitleWidget(),
        centerTitle: true,
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 21, 27, 1),
        child: _Body(),
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

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        MovieDetailsMainInfoWidget(),
        SizedBox(height: 30),
        MovieDetailsMainScreenCastWidget(),
      ],
    );
  }
}
