import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/gps/view_gps/gps_screen.dart';
import 'package:web_dashboard/ui/modals/taxoperation_modal.dart';
import 'package:web_dashboard/ui/modals/taxsale_modal.dart';
import 'package:web_dashboard/ui/views/bank_view.dart';
import 'package:web_dashboard/ui/views/banks_view.dart';
import 'package:web_dashboard/ui/views/finance_view.dart';
import 'package:web_dashboard/ui/views/finances_view.dart';
import 'package:web_dashboard/ui/views/orden_view.dart';
import 'package:web_dashboard/ui/views/orders_records_view.dart';
import 'package:web_dashboard/ui/views/product_view.dart';
import 'package:web_dashboard/ui/views/profile_view.dart';
import 'package:web_dashboard/ui/views/profiles_view.dart';
import 'package:web_dashboard/ui/views/categories_view.dart';
import 'package:web_dashboard/ui/views/customer_view.dart';
import 'package:web_dashboard/ui/views/customers_view.dart';

import 'package:web_dashboard/ui/views/dashboard_view.dart';
import 'package:web_dashboard/ui/views/inactive_user_view.dart';
import 'package:web_dashboard/ui/views/login_view.dart';
import 'package:web_dashboard/ui/views/marketing_view.dart';
import 'package:web_dashboard/ui/views/message_view.dart';
import 'package:web_dashboard/ui/views/new_customer_view.dart';
import 'package:web_dashboard/ui/views/new_user_register.dart';
import 'package:web_dashboard/ui/views/orders_view.dart';
import 'package:web_dashboard/ui/views/products_view.dart';
import 'package:web_dashboard/ui/views/ruta_view.dart';
import 'package:web_dashboard/ui/views/rutas_view.dart';
import 'package:web_dashboard/ui/views/zone_view.dart';
import 'package:web_dashboard/ui/views/zones_view.dart';
import 'package:web_dashboard/ui/views/settings_view.dart';
import 'package:web_dashboard/ui/views/user_view.dart';
import 'package:web_dashboard/ui/views/users_view.dart';



class DashboardHandlers {

  static Handler dashboard = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.dashboardRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const DashboardView();
      } return const LoginView();

    }
  );

    static Handler orders = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const OrdersView();
      } return const LoginView();

    }
  );

      static Handler ordersRecords = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersRecordsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const OrdersRecordsView();
      } return const LoginView();

    }
  );

    static Handler orden = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordenRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return OrdenView(id: params['id']!.first);
        }else{
          return const OrdersView();
        }
      } return const LoginView();

    }
  );
  
  

    static Handler gps = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.gpsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const GpsScreen();
      } return const LoginView();

    }
  );

  static Handler products = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.productsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const ProductsView();
      } return const LoginView();

    }
  );


  static Handler product = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.productRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return ProductView(id: params['id']!.first);
        }else{
          return const ProductsView();
        }
      } return const LoginView();

    }
  );

  static Handler categories = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.categoriesRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const CategoriesView();
      } return const LoginView();

    }
  );

    static Handler customers = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.customersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const CustomersView();
      } return const LoginView();

    }
  );

      static Handler customer = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.customerRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if(params['id']?.first != null) {
          return CustomerView(id: params['id']!.first);
        }else {
          return const CustomersView();
        }
      } else {
        return const LoginView();
      }
    }
  );

    static Handler newCustomer = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.newCustomerRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return  NewCustomerView();
      } return const LoginView();

    }
  );

    static Handler routes = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.routeRoutes);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const RutasView();
      } return const LoginView();

    }
  );

    static Handler route = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.routeRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return RutaView(id: params['id']!.first);
        }else{
          return const RutasView();
        }
      } return const LoginView();

    }
  );



    static Handler zones = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.zoneZones);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const ZonesView();
      } return const LoginView();

    }
  );

    static Handler zone = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.zoneZone);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if(params['id']?.first != null) {
          return ZoneView(id: params['id']!.first);
        }else {
          return const ZonesView();
        }
      } else {
        return const LoginView();
      }
    }
  );

  //  static Handler newRoute = Handler (
  //  handlerFunc: (context, params) {
  //    final authProvider = Provider.of<AuthProvider>(context!);
  //    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.newRouteRoute);
  //    if( authProvider.authStatus == AuthStatus.authenticated) {
  //      return const NewRouteView();
  //    } return const LoginView();
//
  //  }
  //);


    static Handler marketing = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.marketingRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const MarketingView();
      } return const LoginView();

    }
  );

    static Handler message = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.messageRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const MessageView();
      } return const LoginView();

    }
  );


  static Handler users = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.usersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const UsersView();
      } return const LoginView();

    }
  ); 


  static Handler user = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.userRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if ( params ['uid']?.first != null ) {
          return UserView(uid: params ['uid']!.first);
        }
      } else {
          return const UsersView();
      } return const LoginView();
    }
  ); 


    static Handler newUserRegister = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.newUserRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const NewUserRegister();
      } return const LoginView();

    }
  );




  // Configuration

    static Handler settings = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.settingsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const SettingsView();
      } return const LoginView();

    }
  );

      static Handler profileSettings = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.profile);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const ProfilesView();
      } return const LoginView();

    }
  );

    static Handler profile = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.profileId);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return ProfileView(id: params['id']!.first);
        }else{
          return const ProfilesView();
        }
      } return const LoginView();

    }
  );


    static Handler inactiveUser = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.inactiveUserRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const InactiveUserView();
      } return const LoginView();

    }
  );

    static Handler finance = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.financeRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const FinancesView();
      } return const LoginView();

    }
  );

    static Handler financebyID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.financeID);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return FinanceView(id: params['id']!.first);
        }else{
          return const FinancesView();
        }
      } return const LoginView();

    }
  );

      static Handler taxSalesbyID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.taxSalesID);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return TaxSaleView(id: params['id']!.first);
        }else{
          return const FinancesView();
        }
      } return const LoginView();

    }
  );


  static Handler taxOperationbyID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.taxOperationID);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return TaxOperationModal(id: params['id']!.first);
        }else{
          return const FinancesView();
        }
      } return const LoginView();

    }
  );
  
  static Handler bank = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.bankRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const BanksView();
      } return const LoginView();

    }
  );
      static Handler bankID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.bankId);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return BankView(id: params['id']!.first);
        }else{
          return const BanksView();
        }
      } return const LoginView();

    }
  );

}

