import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;

  const AppDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected
  }) : super(key: key);

  void onDrawerItemClick(BuildContext context, int index) {
    Navigator.pop(context);
    onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: ListView(
            children: [
              TextButton(
                  onPressed: () => onDrawerItemClick(context, 0),
                  child: Text("Home", style: Theme.of(context).textTheme.labelLarge)
              ),
              TextButton(
                  onPressed: () => onDrawerItemClick(context, 1),
                  child: Text("Movies", style: Theme.of(context).textTheme.labelLarge)
              )
            ],
          )
      ),
    );
  }
}
