import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlineButtom extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;

  const CustomOutlineButtom({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = Colors.grey,
    this.isFilled = false
    });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        side: MaterialStateProperty.all(BorderSide(color: color)),
        backgroundColor: MaterialStateProperty.all(
          isFilled ? color.withOpacity(0.3) : Colors.transparent,
        )
      ),
      onPressed: () => onPressed, 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text( text,
        style:GoogleFonts.plusJakartaSans(
          fontSize: 16,
          color: Colors.grey,
        ),
        ),));
  }
}