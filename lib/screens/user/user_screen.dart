import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/user/screens/profile_screen.dart';
import 'package:movie_night/screens/user/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if(authProvider.user != null) {
      return ProfileScreen(authProvider: authProvider,);
    } else {
      return const SignInScreen();
    }
  }
}