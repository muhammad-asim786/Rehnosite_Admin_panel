import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

Future<String?> showTextEntryDialog(BuildContext context) async {
  String? enteredText;

  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Enter Phone Number"),
        content: Column(
          children: <Widget>[
            CupertinoTextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ], // Allow only digits
              placeholder: "Type Here",
              onChanged: (text) {
                enteredText = text;
              },
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop(enteredText);
            },
            child: Text("Save"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop(null);
              enteredText = null;
            },
            child: Text("Cancel"),
          ),
        ],
      );
    },
  );

  return enteredText;
}
