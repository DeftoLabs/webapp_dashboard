import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Daniel_Craig_in_2021.jpg/1200px-Daniel_Craig_in_2021.jpg',
        width: 30,
        height: 30,
        )
      ),
    );
  }
}