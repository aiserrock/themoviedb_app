import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie(
      {required this.id,
      required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({Key? key}) : super(key: key);

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      imageName: AppImages.jungle,
      title: 'Minecraft Jungle',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
    Movie(
      id: 2,
      imageName: AppImages.jungle,
      title: 'Marcianin',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
    Movie(
      id: 3,
      imageName: AppImages.jungle,
      title: 'Total War',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
    Movie(
      id: 4,
      imageName: AppImages.jungle,
      title: 'Stalker ||',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
    Movie(
      id: 5,
      imageName: AppImages.jungle,
      title: 'Intersteiler',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
    Movie(
      id: 6,
      imageName: AppImages.jungle,
      title: 'American Pie 1',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
    Movie(
      id: 7,
      imageName: AppImages.jungle,
      title: 'American Pie 2',
      time: 'April 10 2012',
      description: 'Dr. Lily Houghton enlists the aid of wisecracking'
          ' skipper Frank Wolff to take her down the Amazon in'
          ' his dilapidated boat. Together, they search for an'
          ' ancient tree that holds the power to heal – a discovery'
          ' that will change the future of medicine.',
    ),
  ];

  var _filteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      '/main_screen/movie_details',
      arguments: id,
    );
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Stack(
                children: [
                  Container(
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
                          Image(
                            image: AssetImage(movie.imageName),
                          ),
                          SizedBox(
                            width: 15,
                          ),
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
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  movie.time,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  movie.description,
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
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _onMovieTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
            ),
          ),
        ),
      ],
    );
  }
}
