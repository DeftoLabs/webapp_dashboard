import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class NoPageAccessView extends StatelessWidget {
  const NoPageAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 350),
          Text('503 - ACCESS DENIED',
          style: GoogleFonts.plusJakartaSans (
            fontSize: 50,
            fontWeight: FontWeight.bold,
          )),
          Text('Contact Support',
          style: GoogleFonts.plusJakartaSans (
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
        ],
      )
    );
  }
}