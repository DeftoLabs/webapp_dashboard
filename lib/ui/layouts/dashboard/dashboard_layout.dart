import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/shared/navbar.dart';

import 'package:web_dashboard/ui/shared/sidebar.dart';

class DashboardLayout extends StatelessWidget {

  final Widget child;

  const DashboardLayout({
    super.key, 
    required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Row(
        children: [
          // TODO: este depende de si es mas de 700px
          const Sidebar(),

          Expanded(
            child: Column(
              children: [
              // Navbar
              const Navbar(),         
                
              // View  
              Expanded(child: child),
              ],
            ),
          ),
        ],
      )
    );
  }
}