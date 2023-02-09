import 'package:flutter/material.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';

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
    return ListView(
      children: [
        TextButton(
            onPressed: logOut,
            child: const Text("Sign out")
        )
      ],
    );
  }
}
