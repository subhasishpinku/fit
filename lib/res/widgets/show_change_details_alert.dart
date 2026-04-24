import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showChangeDetailsAlert(BuildContext context, VoidCallback onConfirm) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text("Alert", style: TextStyle(fontWeight: FontWeight.bold)),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          "Changing your details will create a new exercise plan and your new plan will start from today.\nDo you want to proceed?",
          style: TextStyle(fontSize: 15),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: false,
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.red)),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.changeDetails);

            onConfirm();
          },
          child: const Text(
            "YES",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
