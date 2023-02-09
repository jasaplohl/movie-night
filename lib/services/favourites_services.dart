import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
import 'package:provider/provider.dart';

void toggleFavourite(int id, MediaType mediaType, BuildContext context) {
  final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
  if(authProvider.user == null) {
    showSignInDialog(context);
  } else {
    print("Adding to favourites: $id ($mediaType)");
  }
}