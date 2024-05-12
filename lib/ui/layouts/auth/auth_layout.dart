import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/layouts/auth/widgets/background_image.dart';
import 'package:web_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:web_dashboard/ui/layouts/auth/widgets/links_bar.dart';

class AuthLayout extends StatelessWidget {

  final Widget child;

  const AuthLayout({
    super.key,
    required this.child
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          // Desktop

          _DesktopBody(child: child),

          // Mobile

          // LinksBar
          const LinksBar(),

        ],

      )
    );
  }
}
class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({super.key, required this.child});


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
              child: Column(
                children: [
                  const CustomTitle(),
                  const SizedBox(height: 50),
                  Expanded(child: child),
                ],
              )
            )
        ],
      )

    );
  }
}