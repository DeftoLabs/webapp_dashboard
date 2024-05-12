import 'package:flutter/material.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/ui/layouts/auth/auth_layout.dart';

void main () {

  Flurorouter.configureRoutes();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      builder: (_, child) {
        return AuthLayout();
      },
    );
  }
}