import 'package:flutter/material.dart';

class WatchHistoryScreen extends StatefulWidget {
  const WatchHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WatchHistoryScreen> createState() => _WatchHistoryScreenState();
}

class _WatchHistoryScreenState extends State<WatchHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Watch History"),),
      body: const Center(
        child: Text("Your watch history."),
      ),
    );
  }
}
