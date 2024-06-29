import 'package:flutter/material.dart';

Future<void> showPopupWidget(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const PopupWidget(),
  );
}

class PopupWidget extends StatelessWidget {
  const PopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
