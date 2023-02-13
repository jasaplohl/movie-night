import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final bool accentColor;

  const LoadingSpinner({
    Key? key,
    this.accentColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          accentColor ?
          Colors.black :
          Theme.of(context).primaryColorLight
        ),
      ),
    );
  }
}
