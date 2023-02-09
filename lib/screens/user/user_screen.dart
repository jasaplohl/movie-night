import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/user/screens/profile_screen.dart';
import 'package:movie_night/screens/user/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

// showLicensePage(context: context); // TODO: Show license page

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserInfo? userInfo;
    if(authProvider.user != null) {
      userInfo = authProvider.user!.providerData[0];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(userInfo == null ? "Your Profile" : userInfo.displayName!, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight)),
      ),
      body: authProvider.user != null ?
      const ProfileScreen() :
      const SignInScreen(),
    );
  }
}