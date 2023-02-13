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
                TextButton.icon(
                  icon: const Icon(Icons.favorite),
                  label: const Text("Favourites"),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen(),)),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.bookmark),
                  label: const Text("Watchlist"),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WatchListScreen(),)),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.history),
                  label: const Text("Watch History"),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WatchHistoryScreen(),)),
                ),
              ],
            ),
            Column(
              children: [
                const Divider(),
                TextButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text("Settings"),
                  onPressed: null,
                ),
                TextButton(
                  onPressed: () => _licensePage(context),
                  child: const Text("Licenses"),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text("Sign out", style: TextStyle(color: Colors.red),),
                  onPressed: () => _signOut(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
