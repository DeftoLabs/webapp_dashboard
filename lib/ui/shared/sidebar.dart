
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/providers.dart';
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

    final currentUser = Provider.of<AuthProvider>(context).user!;

    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

        const Logo(),

        MenuItem(
          isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          text: 'Dashboard', 
          icon: Icons.compass_calibration_outlined, 
          onPressed: ()=> navigateTo(Flurorouter.dashboardRoute)),

        currentUser.rol != 'USER_ROLE'
          ? MenuItem(
              text: 'Analityc',
              icon: Icons.account_tree_outlined,
             onPressed: ()=> navigateTo(Flurorouter.analitycRoute)
            )
          : const SizedBox.shrink(),

        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),
        ),


        MenuItem(text: 'Orders', 
        icon: Icons.list_alt_outlined,            
        onPressed: ()=> navigateTo(Flurorouter.ordersRoute)),

        MenuItem(text: 'Shipment', icon: Icons.local_shipping_outlined,      
            onPressed: ()=> navigateTo(Flurorouter.shipmentRoute)
        ),

        MenuItem(text: 'Payments', icon: Icons.account_balance_wallet_outlined,      
        onPressed: ()=> navigateTo(Flurorouter.paymentsRoute)),
        
        const SizedBox(height: 10),

        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),
        ),

        MenuItem(text: 'Products', 
        icon: Icons.shopping_bag_outlined,    
        onPressed: ()=> navigateTo(Flurorouter.productsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.productsRoute,),

        MenuItem(text: 'Catalog', icon: Icons.share_rounded,      
         onPressed: ()=> navigateTo(Flurorouter.catalogRoute)
        ),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: 'Categories', 
        icon: Icons.category_outlined,        
        onPressed: ()=> navigateTo(Flurorouter.categoriesRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,)
        : const SizedBox.shrink(),

        const SizedBox(height: 10),

        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),
        ),

        MenuItem(text: 'Customers', 
        icon: Icons.add_business_outlined,  
       onPressed: ()=> navigateTo(Flurorouter.customersRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.customersRoute,),

        const SizedBox(height: 10),

        currentUser.rol != 'USER_ROLE'
        ? 
        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1))
        : const SizedBox.shrink(),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: 'GPS', icon: Icons.gps_fixed,                  
        onPressed: ()=> navigateTo(Flurorouter.gpsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.gpsRoute,)
        : const SizedBox.shrink(),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: 'Route', icon: Icons.route_rounded,
        onPressed: ()=> navigateTo(Flurorouter.routeRoutes),
        isActive: sideMenuProvider.currentPage == Flurorouter.routeRoutes,)
        : const SizedBox.shrink(),   

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: 'Zone', icon: Icons.landscape_outlined,      
        onPressed: ()=> navigateTo(Flurorouter.zoneZones),
        isActive: sideMenuProvider.currentPage == Flurorouter.zoneZones,)
        : const SizedBox.shrink(),   
      
        const SizedBox(height: 10),

        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),
        ),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: 'Users', 
        icon: Icons.accessibility_outlined,
        onPressed: ()=> navigateTo(Flurorouter.usersRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,)
        : const SizedBox.shrink(),   

        MenuItem(text: 'Marketing', 
        icon: Icons.trending_up_outlined,
        onPressed: ()=> navigateTo(Flurorouter.marketingRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.marketingRoute,),

        MenuItem(text: 'Message', 
        icon: Icons.sms,
        onPressed: ()=> navigateTo(Flurorouter.messageRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.messageRoute,
        ),


        const SizedBox(height: 50),

        const TextSeparator(text: 'Configuration'),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: 'Settings', 
        icon: Icons.tune_outlined, 
        onPressed: ()=> navigateTo(Flurorouter.settingsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.settingsRoute,)
        : const SizedBox.shrink(),   


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