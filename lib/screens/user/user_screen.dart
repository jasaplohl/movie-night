import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/user/screens/profile_screen.dart';
import 'package:movie_night/screens/user/screens/sign_in_screen.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  void _signOut(BuildContext context) async {
    try {
      await signOut();
    } catch (err) {
      showErrorDialog(context, err.toString());
    }
  }

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
        actions: [
          PopupMenuButton(
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    onTap: () => showLicensePage(context: ctx), // TODO: fix
                    child: const Text("Licenses"),
                  ),
                  if(userInfo != null) PopupMenuItem(
                    onTap: () => _signOut(context),
                    child: const Text("Sign out", style: TextStyle(color: Colors.red),),
                  ),
                ];
              },
          )
        ],
      ),
      body: authProvider.user != null ?
      ProfileScreen(authProvider: authProvider,) :
      const SignInScreen(),
    );
  }
}