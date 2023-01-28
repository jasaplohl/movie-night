import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Movie>? popularMovies;

  @override
  void initState() {
    getPopularMovies().then((List<Movie> value) {
      setState(() {
        popularMovies = value;
      });
    }).catchError((err) {
      // TODO: display error messages
      print(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
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
                Icon(Icons.home),
                Icon(Icons.movie),
                Icon(Icons.tv),
                Icon(Icons.category),
              ]
          ),
        )
    );
    //   ListView(
    //   children: [
    //     MovieRow(
    //         title: "Popular",
    //         movies: popularMovies
    //     ),
    //   ],
    // );
  }
}
