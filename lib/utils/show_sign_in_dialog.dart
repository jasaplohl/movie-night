import 'package:flutter/material.dart';
import 'package:movie_night/widgets/google_sign_in_button.dart';

Future<void> showSignInDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        elevation: 10,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.login_outlined),
              SizedBox(height: 10,),
              Text("Please sign in"),
              SizedBox(height: 10,),
              GoogleSignInButton(popContext: true),
            ],
          ),
        ),
      );
    },
  );
}