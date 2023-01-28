import 'package:flutter/material.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({Key? key}) : super(key: key);

  @override
  State<WatchedScreen> createState() => _WatchedScreenState();
}

class _WatchedScreenState extends State<WatchedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Already watched")
    );
  }
}
