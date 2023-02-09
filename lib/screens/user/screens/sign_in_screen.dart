import 'package:flutter/material.dart';
import 'package:movie_night/widgets/google_sign_in_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("Please log in to see your favourite and already watched movies!", textAlign: TextAlign.center),
        SizedBox(height: 15),
        GoogleSignInButton(),
      ],
    );
  }
}
