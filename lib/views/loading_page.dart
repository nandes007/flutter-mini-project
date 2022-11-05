import 'package:flutter/material.dart';
import 'package:laundry_app/model/api/auth_api.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  initAuthProvider(context) async {
    Provider.of<AuthAPI>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laudry App'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
