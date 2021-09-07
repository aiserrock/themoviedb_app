import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Text(
            'Index 0: News',
          ),
          MovieListWidget(),
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
