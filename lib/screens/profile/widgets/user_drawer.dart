import 'package:flutter/material.dart';
import 'package:movie_night/screens/profile/screens/favourites_screen.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  void _signOut(BuildContext context) async {
    try {
      await signOut();
    } catch (err) {
      showErrorDialog(context, err.toString());
    }
  }

  void _licensePage(BuildContext context) {
    _closeDrawer(context);
    showLicensePage(
      context: context,
      useRootNavigator: true,
      applicationVersion: "1.0.0",
      applicationName: "MovieWatch",
    );
  }

  void _closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const TextButton(
                  onPressed: null,
                  child: Text("Watchlist"),
                ),
                const TextButton(
                  onPressed: null,
                  child: Text("Already watched"),
                ),
                const Divider(),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen(),)),
                  child: const Text("Favourites"),
                ),
              ],
            ),
            Column(
              children: [
                const Divider(),
                const TextButton(
                  onPressed: null,
                  child: Text("Settings"),
                ),
                TextButton(
                  onPressed: () => _licensePage(context),
                  child: const Text("Licenses"),
                ),
                TextButton(
                  onPressed: () => _signOut(context),
                  child: const Text("Sign out", style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
