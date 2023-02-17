import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/auth_service.dart';
import 'package:movie_night/services/notification_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  final NotificationService notificationService = NotificationService();
  final bool popContext;

  GoogleSignInButton({Key? key, this.popContext = false}) : super(key: key);

  Future<void> signInWithGoogle(BuildContext context) async {
    // TODO: Loading spinner
    print("Loading ...");
    await googleSignIn().then((_) {
      if(popContext) {
          Navigator.of(context).pop();
      }
      final String? username = Provider.of<AuthProvider>(context, listen: false).user?.providerData[0].displayName;
      notificationService.showNotification(username);
      print("Loading done.");
    })
    .catchError((err) {
      print("Loading done with an error.");
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
