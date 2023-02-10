import 'package:flutter/material.dart';
import 'package:movie_night/widgets/google_sign_in_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile",style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please log in to see your favourite and already watched movies!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            const GoogleSignInButton(),
          ],
        ),
      ),
    );
  }
}
