

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
          borderRadius: BorderRadius.circular(20)
        )),
        backgroundColor: WidgetStateProperty.all(color),
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

class CustomIconButtonClear extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButtonClear({
    super.key, 
    required this.onPressed, 
    required this.text, 
    required this.icon,
    this.color = const Color.fromRGBO(177, 255, 46, 1),
    this.isFilled = false, 
    });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style:ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )),
        backgroundColor: WidgetStateProperty.all(color),
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

class CustomIconButtonColor extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButtonColor({
    super.key, 
    required this.onPressed, 
    required this.text, 
    required this.icon,
    this.color = Colors.white,
    this.isFilled = false, 
    });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style:ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )),
        backgroundColor: WidgetStateProperty.all(color),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 24)), 
        minimumSize: WidgetStateProperty.all(const Size(50, 60)), 
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