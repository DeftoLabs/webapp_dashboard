

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
  
          const SizedBox(height: 50),

          FittedBox(
            fit: BoxFit.contain,
            child: Text('Fuel your Sales !!',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
             )),
          )
        ],
      )
    );
  }
}