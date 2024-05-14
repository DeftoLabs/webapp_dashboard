

import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: (size.width > 1000) ? size.height * 0.07 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText (text: 'About', onPressed: () => print ('about'),),
          LinkText (text: 'Help Center'),
          LinkText (text: 'Term of Service'),
          LinkText (text: 'Privacy Policy'),
        ],
      )
    );
  }
}