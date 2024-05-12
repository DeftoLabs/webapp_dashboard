import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/layouts/auth/widgets/background_image.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Desktop

          _DesktopBody(),

          // Mobile

          // LinksBar
        ],

      )
    );
  }
}
class _DesktopBody extends StatelessWidget {
  const _DesktopBody({super.key});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.pink[300],
      child: Row(
        children: [

          //Backgorund
          const BackgroundImage(),

          // View Container
            Container(
              width: 600,
              height: double.infinity,
              color: Colors.amber[50],
              //child: 
            )
        ],
      )

    );
  }
}