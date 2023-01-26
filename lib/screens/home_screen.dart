import 'package:flutter/material.dart';
import 'package:movie_night/screens/home/favourites_screen.dart';
import 'package:movie_night/screens/home/movies_screen.dart';
import 'package:movie_night/screens/home/search_screen.dart';
import 'package:movie_night/screens/home/watched_screen.dart';
import 'package:movie_night/widgets/bottom_navigation.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  final List<Widget> pages = [
    const MoviesScreen(),
    const SearchScreen(),
    const FavouritesScreen(),
    const WatchedScreen()
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  void pageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(selectedIndex: currentPage, onItemSelected: pageChange),
      bottomNavigationBar: BottomNavigation(selectedIndex: currentPage, onItemSelected: pageChange),
      body: widget.pages[currentPage],
    );
  }
}
