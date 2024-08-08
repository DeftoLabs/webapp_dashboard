

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;

  const WhiteCard({
    super.key,
    required this.child,
    this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (title != null)
            ...[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title!,
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
            ],
          Center(child: child), // Centra el contenido principal
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}

class WhiteCardColor extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final Color backgroundColor;
  final Color titleColor;

  const WhiteCardColor({
    super.key,
    required this.child,
    this.title,
    this.width,
    this.backgroundColor =  const Color.fromARGB(255, 58, 60, 65),
    this.titleColor = Colors.white,
  });

 @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (title != null)
            ...[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title!,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: titleColor), // Usa el color del título aquí
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
            ],
          Center(child: child), // Centra el contenido principal
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: backgroundColor, // Usa el color de fondo aquí
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}