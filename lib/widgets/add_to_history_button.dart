import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';

class AddToHistoryButton extends StatefulWidget {
  final int id;
  final MediaType mediaType;

  const AddToHistoryButton({
    Key? key,
    required this.id,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<AddToHistoryButton> createState() => _AddToHistoryButtonState();
}

class _AddToHistoryButtonState extends State<AddToHistoryButton> {

  bool loading = false;

  Future<void> onHistoryTap() async {
    setState(() {
      loading = true;
    });
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.user != null) {
      try {
        await authProvider.toggleHistory(widget.id, widget.mediaType);
      } catch(err) {
        showErrorDialog(context, err.toString());
      }
    } else {
      showSignInDialog(context);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(loading) {
      return const IconButton(
        onPressed: null,
        icon: SizedBox(
          width: 12,
          height: 12,
          child: LoadingSpinner(),
        ),
      );
    } else {
      return IconButton(
          onPressed: onHistoryTap,
          icon: Consumer<AuthProvider>(
            builder: (context, AuthProvider provider, child) {
              if (provider.user != null) {
                // TODO: Make get item an async function to not block the thread
                final SavedMedia? historyItem = provider.getHistoryItem(
                    widget.id, widget.mediaType);
                if (historyItem != null) {
                  return const Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                  );
                }
              }
              return child!;
            },
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.green,
            ),
          )
      );
    }
  }
}
