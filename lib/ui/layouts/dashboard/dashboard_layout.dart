import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardLayout extends StatelessWidget {

  final Widget child;

  const DashboardLayout({
    super.key, 
    required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard', style: GoogleFonts.plusJakartaSans(fontSize: 50, fontWeight: FontWeight.bold) )
      )
    );
  }
}