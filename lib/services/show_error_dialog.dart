import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String errorMessage) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("There has been an error!"),
          content: Text(errorMessage),
          elevation: 10,
          icon: const Icon(Icons.error_outline),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
            )
          ],
        );
      },
  );
}