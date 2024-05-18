

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {

  final String? title;
  final Widget child;

  const WhiteCard({
    super.key, 
  this.title, 
  required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if( title !=null)
        ... [ FittedBox(
            fit: BoxFit.contain,
            child: Text (
              title!,
              style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold)
            ),
          ),
          
          const Divider()

          ],

          child
        ],
      )
    ) ;
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 5,
      )
    ]
  );
}