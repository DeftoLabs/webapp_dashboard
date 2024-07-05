import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCardMap extends StatefulWidget {
  final String? title;
  final Widget child;
  final double? width;

  const WhiteCardMap({
    super.key,
    required this.child,
    this.title,
    this.width,
  });

  @override
  State<WhiteCardMap> createState() => _WhiteCardMapState();
}

class _WhiteCardMapState extends State<WhiteCardMap> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final remainingHeight = screenSize.height -
        kToolbarHeight -
        8 * 2 -
        10 * 2 -
        20 -
        20 -
        20 -
        (widget.title != null ? 20 : 0);
    return Container(
        width: widget.width ?? screenSize.width,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(children: [
              if (widget.title != null) ...[
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(widget.title!,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
              ]
            ]),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            SizedBox(height: remainingHeight, child: widget.child),
          ],
        ));
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ]);
}
