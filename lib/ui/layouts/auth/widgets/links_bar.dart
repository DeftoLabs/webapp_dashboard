

import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: const Color.fromRGBO(215, 255, 148, 50),
      height: (size.width > 1000) ? size.height * 0.07 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText (text: 'About', onPressed: (){}),
          const LinkText (text: 'Help Center'),
          const LinkText (text: 'Term of Service'),
          const LinkText (text: 'Privacy Policy'),
          const LinkText (text: '@copyrigth 2024 All Rigth Reverved '),
        ],
      )
    );
  }
}