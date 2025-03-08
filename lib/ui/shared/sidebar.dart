
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
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

    final localization = AppLocalizations.of(context)!;

    return Container(
      width: 210,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

        const Logo(),

        MenuItem(
          isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          text: localization.dashboard, 
          icon: Icons.compass_calibration_outlined, 
          onPressed: ()=> navigateTo(Flurorouter.dashboardRoute)),

        currentUser.rol != 'USER_ROLE'
          ? MenuItem(
              text: localization.estadistic,
              icon: Icons.account_tree_outlined,
             onPressed: ()=> navigateTo(Flurorouter.analitycRoute)
            )
          : const SizedBox.shrink(),

        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),
        ),

      // Double Menu ( ADMIN_ROLE & USER_ROLE)

      // ADMIN_ROLE
        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text: localization.orders, 
        icon: Icons.list_alt_outlined,      
        onPressed: ()=> navigateTo(Flurorouter.ordersRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.ordersRoute,)
        : const SizedBox.shrink(),
      // USER_ROLE
        (currentUser.rol != 'MASTER_ROL' && currentUser.rol != 'ADMIN_ROLE') 
        ? MenuItem(
        text:  localization.orders,
        icon: Icons.list_alt_outlined,
        onPressed: () => navigateTo(Flurorouter.ordersSalesRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.ordersSalesRoute,
          )
        : const SizedBox.shrink(),


        MenuItem(text:  localization.shipment, icon: Icons.local_shipping_outlined,      
            onPressed: ()=> navigateTo(Flurorouter.shipmentRoute)
        ),

              // ADMIN_ROLE
        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text:  localization.payments, 
        icon: Icons.account_balance_wallet_outlined,    
        onPressed: ()=> navigateTo(Flurorouter.paymentsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.paymentsRoute)
        : const SizedBox.shrink(),
      // USER_ROLE
        (currentUser.rol != 'MASTER_ROL' && currentUser.rol != 'ADMIN_ROLE') 
        ? MenuItem(
        text:  localization.payments,
        icon: Icons.account_balance_wallet_outlined,
        onPressed: ()=> navigateTo(Flurorouter.paymentsSalesRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.paymentsSalesRoute)
        : const SizedBox.shrink(),
        
        const SizedBox(height: 10),

        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),
        ),

        currentUser.rol != 'USER_ROLE'
        ?
        MenuItem(text:  localization.products, 
        icon: Icons.shopping_bag_outlined,    
        onPressed: ()=> navigateTo(Flurorouter.productsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.productsRoute,)
        : const SizedBox.shrink(),

        MenuItem(text:  localization.catalog, icon: Icons.share_rounded,      
         onPressed: ()=> navigateTo(Flurorouter.catalogRoute)
        ),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text:  localization.categories, 
        icon: Icons.category_outlined,        
        onPressed: ()=> navigateTo(Flurorouter.categoriesRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,)
        : const SizedBox.shrink(),

        currentUser.rol != 'USER_ROLE'
        ?
        const SizedBox(height: 10)
        : const SizedBox.shrink(),

        currentUser.rol != 'USER_ROLE'
        ?
        const Divider(
          indent: 30,
          endIndent: 30,
          color: Color.fromRGBO(177, 255, 46, 1),)
          : const SizedBox.shrink(),

        currentUser.rol != 'USER_ROLE'
        ?
        MenuItem(text:  localization.customers, 
        icon: Icons.add_business_outlined,  
       onPressed: ()=> navigateTo(Flurorouter.customersRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.customersRoute,)
        : const SizedBox.shrink(),

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
        MenuItem(text:  localization.gps, icon: Icons.gps_fixed,                  
        onPressed: ()=> navigateTo(Flurorouter.gpsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.gpsRoute,)
        : const SizedBox.shrink(),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text:  localization.route, icon: Icons.route_rounded,
        onPressed: ()=> navigateTo(Flurorouter.routeRoutes),
        isActive: sideMenuProvider.currentPage == Flurorouter.routeRoutes,)
        : const SizedBox.shrink(),   

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text:  localization.zone, icon: Icons.landscape_outlined,      
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
        MenuItem(text:  localization.users, 
        icon: Icons.accessibility_outlined,
        onPressed: ()=> navigateTo(Flurorouter.usersRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,)
        : const SizedBox.shrink(),   

        MenuItem(text:  localization.marketing, 
        icon: Icons.trending_up_outlined,
        onPressed: ()=> navigateTo(Flurorouter.marketingRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.marketingRoute,),

        MenuItem(text:  localization.message, 
        icon: Icons.sms,
        onPressed: ()=> navigateTo(Flurorouter.messageRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.messageRoute,
        ),


        const SizedBox(height: 50),

        TextSeparator(text:  localization.preferences),

        currentUser.rol != 'USER_ROLE'
        ? 
        MenuItem(text:  localization.settings,
        icon: Icons.tune_outlined, 
        onPressed: ()=> navigateTo(Flurorouter.settingsRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.settingsRoute,)
        : const SizedBox.shrink(),   

        MenuItem(text:  localization.support, 
        icon: Icons.sms,
        onPressed: ()=> navigateTo(Flurorouter.supportRoute),
        isActive: sideMenuProvider.currentPage == Flurorouter.supportRoute,
        ),


        MenuItem(text:  localization.logout,
        icon: Icons.logout_outlined,
        onPressed: (){
          Provider.of<AuthProvider>(context, listen: false).logout(context);
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
        Color.fromARGB(255, 64, 68, 75),
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