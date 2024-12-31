import 'package:flutter/material.dart';

AppBar getAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.grey.shade300,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.pink, fontSize: 20, fontWeight: FontWeight.w600),
    ),
    actions: actions,
  );
}

dialogBox(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback positiveOnPress,
    required VoidCallback negativeOnPress}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        menuButtonChild('Okay', positiveOnPress),
        menuButtonChild('No', negativeOnPress),
      ],
    ),
  );
}

Widget menuButtonChild(String title, VoidCallback onPress) {
  return TextButton(
    onPressed: onPress,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.pink, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(14),
      child:  Text(title, style: TextStyle(color: Colors.white)),
    ),
  );
}
