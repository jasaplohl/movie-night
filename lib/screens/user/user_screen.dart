import 'package:flutter/material.dart';

// showLicensePage(context: context); // TODO: Show license page

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight))),
      body: const Center(
        child: Text("Please log in to see your favourite and already watched movies!"),
      ),
    );
  }
}