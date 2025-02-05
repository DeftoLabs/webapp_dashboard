

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCardNewUser extends StatelessWidget {

  final String? title;
  final Widget child;
  final double? width;

  const WhiteCardNewUser({
    super.key,  
  required this.child,
  this.title, 
  this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin:const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if( title !=null)
        ... [ FittedBox(
            fit: BoxFit.contain,
            child: Text (
              title!,
              style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold)
            ),
          ),
          const SizedBox(height: 20,),
          const Divider(),
          const SizedBox(height: 20),

          ],

          child
        ],
      )
    ) ;
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: const Color.fromARGB(206, 255, 255, 255),
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 5,
      )
    ]
  );
}