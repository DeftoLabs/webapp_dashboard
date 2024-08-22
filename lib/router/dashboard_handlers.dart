import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/gps/view_gps/gps_screen.dart';
import 'package:web_dashboard/ui/modals/product_view.dart';
import 'package:web_dashboard/ui/views/blank_view.dart';
import 'package:web_dashboard/ui/views/categories_view.dart';
import 'package:web_dashboard/ui/views/customer_view.dart';
import 'package:web_dashboard/ui/views/customers_view.dart';

import 'package:web_dashboard/ui/views/dashboard_view.dart';
import 'package:web_dashboard/ui/views/inactive_user_view.dart';
import 'package:web_dashboard/ui/views/login_view.dart';
import 'package:web_dashboard/ui/views/marketing_view.dart';
import 'package:web_dashboard/ui/views/message_view.dart';
import 'package:web_dashboard/ui/views/my_account_view.dart';
import 'package:web_dashboard/ui/views/new_customer_view.dart';
import 'package:web_dashboard/ui/views/new_user_register.dart';
import 'package:web_dashboard/ui/views/orders_view.dart';
import 'package:web_dashboard/ui/views/products_view.dart';
import 'package:web_dashboard/ui/views/route_view.dart';
import 'package:web_dashboard/ui/views/routes_view.dart';
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
        return const NewCustomerView();
      } return const LoginView();

    }
  );



    static Handler routes = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.routesRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const RoutesView();
      } return const LoginView();

    }
  );

    static Handler route = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.routeRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if(params['id']?.first != null) {
          return RouteView(id: params['id']!.first);
        }else {
          return const RoutesView();
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

      static Handler myAccountSettings = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.myAccount);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const MyAccountView();
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
}

