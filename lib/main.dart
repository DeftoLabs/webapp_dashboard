import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/ui/layouts/auth/auth_layout.dart';

void main () {

  Flurorouter.configureRoutes();
  runApp(const AppState());

}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthProvider()),
      ],
      child: const MyApp(),
      );
  }
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
        return AuthLayout(child: child!);
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: const MaterialStatePropertyAll(Colors.white)
        )
      )
    );
  }
}