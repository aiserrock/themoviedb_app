import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/widgets/movie_list_page/provider/movie_list_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    TextEditingController? searchController,
    required this.model
  }) :super(key: key);

  final  MovieListModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchMovie,
        decoration: InputDecoration(
          labelText: 'Search',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
        ),
      ),
    );
  }
}