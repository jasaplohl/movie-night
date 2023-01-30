import 'package:flutter/material.dart';

class GenreScreen extends StatefulWidget {
  final int genreId;
  const GenreScreen({Key? key, required this.genreId}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genreId.toString())),
    );
  }
}
