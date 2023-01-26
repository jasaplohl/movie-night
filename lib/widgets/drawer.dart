import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void redirect(String path) {
    print("Go to path: $path");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () => redirect("upcoming"),
                  child: const Text("Upcomming")
              )
            ],
          )
      ),
    );
  }
}
