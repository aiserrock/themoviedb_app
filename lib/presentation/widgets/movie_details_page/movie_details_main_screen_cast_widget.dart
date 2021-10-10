import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/data/helpers/api_client/api_client.dart';
import 'package:themoviedb/data/helpers/custom_provider.dart';
import 'package:themoviedb/presentation/widgets/movie_details_page/provider/movie_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Series Cast',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 220,
            child: Scrollbar(
              child: _ActorListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: TextButton(
              onPressed: () {},
              child: Text('Full Cast & Crew'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: 20,
      itemExtent: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _ActorListItemWidget(actorIndex: index);
      },
    );
  }
}

class _ActorListItemWidget extends StatelessWidget {
  const _ActorListItemWidget({
    Key? key,
    required this.actorIndex,
  }) : super(key: key);
  final int actorIndex;

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    var actor = model?.movieDetails?.credits.cast[actorIndex];
    final profilePath = actor?.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: cardDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              profilePath != null
                  ? Image.network(ApiClient.imageUrl(profilePath),height: 100,fit: BoxFit.fitWidth,width: 120,)
                  : const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actor!.name,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      actor.character,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}
