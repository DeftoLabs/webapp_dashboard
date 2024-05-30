

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RectangularCard extends StatelessWidget {

  final String? title;
  final Widget child;
  final double? width;
  final double? heigth;
  final VoidCallback? onTap;


  const RectangularCard({
    super.key,  
  required this.child,
  this.title, 
  this.width,
  this.heigth,
  this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: heigth,
        margin:const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(height: 10),
      
            ],
      
            child
          ],
        )
      ),
    ) ;
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.indigo.withOpacity(0.4),
        blurRadius: 5,
      )
    ]
  );
}