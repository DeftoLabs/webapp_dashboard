

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton({
    super.key, 
    required this.onPressed, 
    required this.text, 
    required this.icon,
    this.color = const Color.fromRGBO(177, 255, 46, 100),
    this.isFilled = false, 
    });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style:ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )),
        backgroundColor: WidgetStateProperty.all(color.withOpacity(0.5)),
        overlayColor: WidgetStateProperty.all(color.withOpacity(0.3)), 
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 24)), 
        minimumSize: WidgetStateProperty.all(const Size(100, 60)), 
      ),
      onPressed: () => onPressed(), 
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          Text(text, style: const TextStyle (color: Colors.black))
        ],
      ));
  }
}