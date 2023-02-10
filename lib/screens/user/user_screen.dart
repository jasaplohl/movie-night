import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/profile/profile_screen.dart';
import 'package:movie_night/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if(authProvider.user != null) {
      return const ProfileScreen();
    } else {
      return const SignInScreen();
    }
  }
}