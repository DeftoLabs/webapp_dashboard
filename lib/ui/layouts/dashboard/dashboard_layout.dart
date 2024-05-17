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
                  Expanded(child: widget.child),
                  ],
                ),
              ),
            ],
          ),

          if(size.width < 700) 
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [



                 Transform.translate(
                  offset: Offset(SideMenuProvider.movement.value, 0),
                  child: Sidebar(),
                  )
                ],
              ))
        ],
      )
    );
  }
}