import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final void Function(int) onPageChange;

  const Pagination({Key? key, required this.currentPage, required this.totalPages, required this.onPageChange}) : super(key: key);

  void onPageUp() {
    onPageChange(currentPage + 1);
  }

  void onPageDown() {
    onPageChange(currentPage - 1);
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: currentPage == 1 ? null : onPageDown,
            icon: const Icon(Icons.arrow_back_ios_new)
        ),
        Text(currentPage.toString()),
        IconButton(
          onPressed: currentPage == totalPages ? null : onPageUp,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}