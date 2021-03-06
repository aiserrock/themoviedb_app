import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/pages/movie_list_page/screens/movie_list.dart';
import 'package:themoviedb/presentation/pages/news_page/screens/news.dart';
import 'package:themoviedb/presentation/pages/tw_shows_page/screens/tw_shows.dart';
import 'package:themoviedb/presentation/pages/movie_list_page/provider/movie_list_model.dart';

import '../../../../data/helpers/data_providers/session_data_provider.dart';
import '../../../../data/helpers/custom_provider.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        centerTitle: true,
        actions: [
          // temporary solution for deauthentication user
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          News(),
          NotifierProvider(
              isManagingModel: false,
              create: () => movieListModel,
              child: const MovieList()),
          TwShows(),
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
