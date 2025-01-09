import 'package:flutter/cupertino.dart';

Future<dynamic> customCupertinoDialog({
  required BuildContext context,
  required String? title,
  required String content,
}) {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title == null
            ? null
            : Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
        content: Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          )
        ],
      );
    },
  );
}
