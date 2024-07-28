
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/services/navigation_service.dart';

import 'package:web_dashboard/ui/shared/widget/logo.dart';
import 'package:web_dashboard/ui/shared/widget/menu_item.dart';
import 'package:web_dashboard/ui/shared/widget/text_separator.dart';

class Sidebar extends StatelessWidget {

  void navigateTo( String routeName ) {
   NavigationService.replaceTo( routeName );
   SideMenuProvider.closeMenu();
  }

  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {

    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

        const Logo(),

         const SizedBox(height: 10),

         const TextSeparator (text:'Main'),

         MenuItem(
          isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          text: 'Dashboard', 
          icon: Icons.compass_calibration_outlined, 
          onPressed: ()=> navigateTo(Flurorouter.dashboardRoute)),

        MenuItem(text: 'Orders', icon: Icons.shopping_bag,            onPressed: (){}),
        MenuItem(text: 'Analityc', icon: Icons.analytics,             onPressed: (){}),

        MenuItem(text: 'GPS', icon: Icons.gps_fixed,                  
        onPressed: ()=> navigateTo(Flurorouter.gpsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.gpsRoute,),


        MenuItem(text: 'Products', 
        icon: Icons.dashboard_outlined,    
        onPressed: ()=> navigateTo(Flurorouter.productsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.productsRoute,),

        MenuItem(text: 'Categories', 
        icon: Icons.category_outlined,        
        onPressed: ()=> navigateTo(Flurorouter.categoriesRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,),


        MenuItem(text: 'Customers', icon: Icons.people_alt_outlined,  onPressed: (){}),
        MenuItem(text: 'Sales', icon: Icons.people_alt_outlined,      onPressed: (){}),

        const SizedBox(height: 30),
        

        const TextSeparator(text: 'Elements'),

        MenuItem(text: 'Users', 
        icon: Icons.update_outlined,
        onPressed: ()=> navigateTo(Flurorouter.usersRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,),

        MenuItem(text: 'Marketing', 
        icon: Icons.mark_email_read_outlined,
        onPressed: ()=> navigateTo(Flurorouter.marketingRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.marketingRoute,
        ),

        MenuItem(text: 'Message', 
        icon: Icons.message_outlined,
        onPressed: ()=> navigateTo(Flurorouter.messageRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.messageRoute,
        ),


        const SizedBox(height: 50),

        const TextSeparator(text: 'Configuration'),
        MenuItem(text: 'Settings', 
        icon: Icons.settings_applications_outlined, 
        onPressed: ()=> navigateTo(Flurorouter.settingsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.settingsRoute,),


        MenuItem(text: 'Logout',
        icon: Icons.logout_outlined,
        onPressed: (){
          Provider.of<AuthProvider>(context, listen: false).logout();
        }),

        const SizedBox(height: 30),


        ]
      )
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 58, 60, 65),
        Color.fromARGB(255, 37, 40, 45),
      ]
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
        )
      ]
  );
}