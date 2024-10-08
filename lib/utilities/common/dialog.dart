import 'package:flutter/material.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

coreLoadingDialog({
  required BuildContext context,
  required String content,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(content),
          ],
        ),
      );
    },
  );
}

coreCloseDialog() {
  MyNavigator.pop();
}
