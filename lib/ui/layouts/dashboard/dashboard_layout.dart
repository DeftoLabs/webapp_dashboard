import 'package:flutter/material.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/ui/shared/navbar.dart';

import 'package:web_dashboard/ui/shared/sidebar.dart';

class DashboardLayout extends StatefulWidget {

  final Widget child;

  const DashboardLayout({
    super.key, 
    required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
      );
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              if(size.width >=700)
              const Sidebar(),
          
              Expanded(
                child: Column(
                  children: [
                  // Navbar
                  const Navbar(),         
                    
                  // View  
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: widget.child
                      )),
                  ],
                ),
              ),
            ],
          ),

          if(size.width < 700) 
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _ ) => Stack(
                children: [

                  if(SideMenuProvider.isOpen)
                  Opacity(
                  opacity: SideMenuProvider.opacity.value, 
                  child: GestureDetector(
                    onTap: () => SideMenuProvider.closeMenu(),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.black26,
                    )
                  )
                 ),

                 Transform.translate(
                  offset: Offset(SideMenuProvider.movement.value, 0),
                  child: const Sidebar(),
                  )
                ],
              ))
        ],
      )
    );
  }
}