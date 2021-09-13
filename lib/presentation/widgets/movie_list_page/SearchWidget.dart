import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    TextEditingController? searchController,
  }) :super(key: key);

  //final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        //controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
        ),
      ),
    );
  }
}