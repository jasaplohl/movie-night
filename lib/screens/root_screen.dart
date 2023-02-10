import 'package:flutter/material.dart';
import 'package:movie_night/screens/genre/genres_screen.dart';
import 'package:movie_night/screens/home/home_screen.dart';
import 'package:movie_night/screens/user/user_screen.dart';
import 'package:movie_night/widgets/bottom_navigation.dart';

// TODO: Navigation drawer -> popular, trending, etc???

class RootScreen extends StatefulWidget {
  static const List<Widget> pages = [
    HomeScreen(),
    GenresScreen(),
    UserScreen()
  ];

  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentPage = 0;

  void pageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(selectedIndex: currentPage, onItemSelected: pageChange),
      body: RootScreen.pages[currentPage],
    );
  }
}
