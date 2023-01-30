import 'package:flutter/material.dart';
import 'package:movie_night/screens/home/general_screen.dart';
import 'package:movie_night/screens/home/genres_screen.dart';
import 'package:movie_night/screens/home/movies_screen.dart';
import 'package:movie_night/services/custom_search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("MovieNight", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight)),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: const Icon(Icons.search)
              )
            ],
            bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColorLight,
                tabs: const [
                  Tab(icon: Icon(Icons.home),),
                  Tab(icon: Icon(Icons.movie),),
                  Tab(icon: Icon(Icons.tv),),
                  Tab(icon: Icon(Icons.category),),
                ]
            ),
          ),
          body: const TabBarView(
              children: [
                GeneralScreen(),
                MoviesScreen(),
                Icon(Icons.tv),
                GenresScreen(),
              ]
          ),
        )
    );
  }
}