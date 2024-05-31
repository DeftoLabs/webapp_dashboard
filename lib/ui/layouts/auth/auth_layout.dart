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

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
        
            ( size.width>1000) 
            ? _DesktopBody(child: child) 
            : _MobileBody(child: child),
        
            // LinksBar
            const LinksBar(),
        
          ],
        
        ),
      )
    );
  }
}

class _MobileBody extends StatelessWidget {

  final Widget child;

  const _MobileBody({
    required this.child
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 200,
          width: double.infinity,
          child: BackgroundImage()),
          const CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child
          ),
        //  const SizedBox(
        //    width: double.infinity,
        //    height: 400,
        //    child: BackgroundImage(),
        //  ),
        ],
      )
    );
  }
}

class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({required this.child});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: const Color.fromRGBO(215, 255, 148, 0),
      child: Row(
        children: [

          //Backgorund
          const Expanded(child:BackgroundImage()),
          
          // View Container
            Container(
              width: 600,
              height: double.infinity,
              color: Colors.black,
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