

import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: size.height * 0.05,
      child: const Wrap(
        children: [
          LinkText (text: 'About'),
          LinkText (text: 'Help Center'),
          LinkText (text: 'Term of Service'),
          LinkText (text: 'Privacy Policy'),
        ],
      )
    );
  }
}