import 'package:flutter/material.dart';
import 'package:movie_night/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieWatch',
      theme: ThemeData.dark().copyWith(
        primaryColorLight: Colors.amber,
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),
          headlineMedium: TextStyle(
            color: Colors.amber
          )
        )
      ),
      home: const HomeScreen(),
    );
  }
}