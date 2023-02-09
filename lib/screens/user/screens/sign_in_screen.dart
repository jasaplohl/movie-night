import 'package:flutter/material.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await googleSignIn();
    } catch (err) {
      showErrorDialog(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Please log in to see your favourite and already watched movies!", textAlign: TextAlign.center),
        TextButton(
            onPressed: () => signInWithGoogle(context),
            child: const Text("Sign in with Google")
        ),
      ],
    );
  }
}
