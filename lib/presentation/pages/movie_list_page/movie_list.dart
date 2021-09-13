import 'package:flutter/material.dart';
import 'package:themoviedb/data/helpers/universal_inherits.dart';
import 'package:themoviedb/domain/entities/movie.dart';
import 'package:themoviedb/presentation/widgets/movie_list_page/SearchWidget.dart';
import 'package:themoviedb/presentation/widgets/movie_list_page/provider/movie_list_model.dart';

class MovieList extends StatelessWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if(model == null) return SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = model.movies[index];
            return buildCard(context, movie, index,model);
          },
        ),
        SearchWidget(),
      ],

    );
  }

  Padding buildCard(BuildContext context,Movie movie, int index, MovieListModel? model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Stack(
        children: [
          CardWidget(movie: movie),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model?.onMovieTap(context, index),
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            // Image(image: AssetImage(movie.imageName)),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    movie.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 5),
                  Text(
                    movie.releaseDate?.toString() ?? '636363663',
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
