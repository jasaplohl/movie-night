import 'package:flutter/material.dart';
import 'package:movie_night/screens/home/genres_screen.dart';
import 'package:movie_night/screens/home/home_screen.dart';
import 'package:movie_night/screens/user/user_screen.dart';
import 'package:movie_night/widgets/bottom_navigation.dart';

class RootScreen extends StatefulWidget {
  final List<Widget> pages = [
    const HomeScreen(),
    const GenresScreen(),
    const UserScreen()
  ];

  RootScreen({Key? key}) : super(key: key);

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
      body: widget.pages[currentPage],
    );
  }
}
