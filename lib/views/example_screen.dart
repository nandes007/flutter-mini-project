import 'package:flutter/material.dart';
import 'package:laundry_app/views/auth/login_page.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen(
      {super.key,
      required this.icon,
      required this.message,
      required this.status});
  final Icon icon;
  final String message;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Appbar'),
      ),
      body: alertDialog(context),
    );
  }

  Widget alertDialog(BuildContext context) {
    return AlertDialog(
      // title: const Text('Success'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text('AlertDialog description'),
        ],
      ),
      icon: const Icon(Icons.abc_outlined),
      iconColor: Colors.red,
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'OK',
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
