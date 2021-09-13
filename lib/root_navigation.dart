import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/pages/movie_list_page/movie_list.dart';
import 'package:themoviedb/presentation/widgets/movie_list_page/provider/movie_list_model.dart';

import 'data/helpers/data_providers/session_data_provider.dart';
import 'data/helpers/universal_inherits.dart';

class RootNavigation extends StatefulWidget {
  const RootNavigation({Key? key}) : super(key: key);

  @override
  _RootNavigationState createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }


  @override
  void initState() {
    super.initState();
    movieListModel.loadMovies();
    print('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Text(
            'Index 0: News',
          ),
          NotifierProvider(model: movieListModel, child: const MovieList()),
          Text(
            'Index 2: Tv shows',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV shows'),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
