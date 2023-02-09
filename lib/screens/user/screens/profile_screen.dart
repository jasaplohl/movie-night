import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void logOut() async {
    try {
      await signOut();
    } catch (err) {
      showErrorDialog(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    return ListView(
      children: [
        const Text("Favourite Movies"),
        Text(authProvider.favouriteMovies.toString()),
        const Text("Favourite TV Shows"),
        Text(authProvider.favouriteTvShows.toString()),
        const Text("Favourite People"),
        Text(authProvider.favouritePeople.toString()),
        TextButton(
            onPressed: logOut,
            child: const Text("Sign out")
        )
      ],
    );
  }
}
