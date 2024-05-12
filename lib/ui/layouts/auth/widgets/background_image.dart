

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: Container(
              decoration: buildBoxDecoration(),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Image(image: AssetImage('logo.png'),
                    width: 400,),
                  )
                ),
              )
            ));
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
              image: DecorationImage(image: AssetImage('twitter-bg.png'),
              fit: BoxFit.cover,
              )
            );
  }
}