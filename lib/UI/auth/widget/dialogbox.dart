import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

Future<void> buildDialogBox(
    {required BuildContext context,
    required String title,
    required String content}) {
  return showDialog(
    barrierDismissible: false,
    context: (context),
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TextButton(
            onPressed: () async {
              await OpenMailApp.openMailApp(
                nativePickerTitle: 'Select email app to open',
              );
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
            child: Text(
              "Open mail",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}
