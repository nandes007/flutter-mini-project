import 'package:flutter/material.dart';

class NotificationText extends StatelessWidget {
  final String text;
  final String type;

  const NotificationText({super.key, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;

    if ('info' == type) {
      color = Colors.blue;
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color),
    );
  }
}
