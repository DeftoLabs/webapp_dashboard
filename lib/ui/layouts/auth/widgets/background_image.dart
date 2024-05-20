import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {


  const BackgroundImage({super.key,});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: (size.width > 1000 ) ? const Image(image: AssetImage('wave.png'),
            width: 400,) : const Image(image: AssetImage('wave.png'),
            width: 250,) ,
          )
        ),
      )
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
              image: DecorationImage(image: AssetImage('twitter-bg.png'),
              fit: BoxFit.cover,
              )
            );
  }
}