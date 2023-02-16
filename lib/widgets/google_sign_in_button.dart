import 'package:flutter/material.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';

class GoogleSignInButton extends StatelessWidget {
  final bool popContext;
  const GoogleSignInButton({Key? key, this.popContext = false}) : super(key: key);

  Future<void> signInWithGoogle(BuildContext context) async {
    // TODO: Loading spinner
    await googleSignIn().then((_) {
      if(popContext) {
          Navigator.of(context).pop();
      }
    })
    .catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => signInWithGoogle(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/images/google_sign_in_icon.png",
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 24,),
            Text("SIGN IN WITH GOOGLE", style: TextStyle(
                color: Colors.black.withOpacity(0.54),
                fontSize: 14
            )),
          ],
        ),
      ),
    );
  }
}
