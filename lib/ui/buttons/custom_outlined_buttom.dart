import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlineButtom extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;

  const CustomOutlineButtom({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.white,
    this.isFilled = false
    }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        side: WidgetStateProperty.all(BorderSide(color: color)),
        backgroundColor: WidgetStateProperty.all(
          isFilled ? color.withValues(alpha: 0.3) : Colors.transparent,
        )
      ),
      onPressed: () => onPressed(), 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text( text,
        style:GoogleFonts.plusJakartaSans(
          fontSize: 16,
          color: Colors.white,
        ),
        ),));
  }
}

class CustomOutlineButtomColor extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;

  const CustomOutlineButtomColor({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.white,
    this.isFilled = false
    }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        side: WidgetStateProperty.all(BorderSide(color: color)),
        backgroundColor: WidgetStateProperty.all(
           isFilled ? color.withValues(alpha: 0.7) : Colors.transparent,
        )
      ),
      onPressed: () => onPressed(), 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text( text,
        style:GoogleFonts.plusJakartaSans(
          fontSize: 16,
          color: Colors.white,
        ),
        ),));
  }
}