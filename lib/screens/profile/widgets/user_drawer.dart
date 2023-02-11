import 'package:flutter/material.dart';
import 'package:movie_night/screens/profile/screens/favourites_screen.dart';
import 'package:movie_night/screens/profile/screens/watch_history_screen.dart';
import 'package:movie_night/screens/profile/screens/watch_list_screen.dart';
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
                Container(
                  color: Theme.of(context).primaryColorLight,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "lib/assets/images/default_img.webp",
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen(),)),
                  child: const Text("Favourites"),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WatchListScreen(),)),
                  child: const Text("Watch List"),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WatchHistoryScreen(),)),
                  child: const Text("Watch History"),
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
