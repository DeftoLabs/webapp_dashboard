import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/ui/views/categories_view.dart';

import 'package:web_dashboard/ui/views/dashboard_view.dart';
import 'package:web_dashboard/ui/views/inactive_user_view.dart';
import 'package:web_dashboard/ui/views/login_view.dart';
import 'package:web_dashboard/ui/views/marketing_view.dart';
import 'package:web_dashboard/ui/views/message_view.dart';
import 'package:web_dashboard/ui/views/new_user_register.dart';
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

  static Handler categories = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.categoriesRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const CategoriesView();
      } return const LoginView();

    }
  );

  



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

