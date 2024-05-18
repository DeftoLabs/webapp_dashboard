import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/ui/views/dashboard_view.dart';
import 'package:web_dashboard/ui/views/login_view.dart';
import 'package:web_dashboard/ui/views/marketing_view.dart';



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

    static Handler marketing = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.marketingdRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const MarketingView();
      } return const LoginView();

    }
  );


}

