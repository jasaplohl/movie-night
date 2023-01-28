import 'package:flutter/material.dart';
import 'package:movie_night/screens/home/general_screen.dart';
import 'package:movie_night/screens/home/movies_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("MovieNight", style: Theme.of(context).textTheme.headlineSmall),
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
                Icon(Icons.category),
              ]
          ),
        )
    );
  }
}