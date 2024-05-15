import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox( height: 20),
            Text('Checking . . .', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, color: Colors.pink[300]), )
          ],
        )
      )
    );
  }
}