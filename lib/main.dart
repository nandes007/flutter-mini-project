import 'package:flutter/material.dart';
import 'package:laundry_app/model/api/auth_api.dart';
import 'package:laundry_app/view_model/transaction_view_model.dart';
import 'package:laundry_app/views/auth/login_page.dart';
import 'package:laundry_app/views/home_page.dart';
import 'package:laundry_app/views/loading_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthAPI()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Router(),
      ),
    ),
  );
}

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthAPI>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.uninitialized:
            return const LoadingPage();
          case Status.unauthenticated:
            return const LoginPage();
          case Status.authenticated:
            return const HomePage();
          default:
            return const LoginPage();
        }
      },
    );
  }
}
