import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignedInScreen extends StatefulWidget {
  const SignedInScreen({Key? key}) : super(key: key);

  @override
  State<SignedInScreen> createState() => _SignedInScreenState();
}

class _SignedInScreenState extends State<SignedInScreen> {

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
            onPressed: signOut,
            child: const Text("Sign out")
        )
      ],
    );
  }
}
