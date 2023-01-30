import 'package:flutter/material.dart';

class DividerMargin extends StatelessWidget {
  const DividerMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const Divider(thickness: 3,),
    );
  }
}
