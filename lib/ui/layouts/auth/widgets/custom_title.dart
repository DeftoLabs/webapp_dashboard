

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
  
          const SizedBox(height: 200),

          FittedBox(
            fit: BoxFit.contain,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(' "Nothing is Faster than the Life Itself" ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                 )),
                 const SizedBox(height: 5),
                   Align(
                    alignment: Alignment.centerRight,
                     child: Text('Ayrton Senna',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                       )),
                   ),
              ],
            ),
          )
        ],
      )
    );
  }
}