

import 'package:fluro/fluro.dart';
import 'package:web_dashboard/router/admin_handlers.dart';
import 'package:web_dashboard/router/dashboard_handlers.dart';
import 'package:web_dashboard/router/no_page_found_handlers.dart';

class Flurorouter {

  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  static String loginRoute =    '/auth/login';
  static String registerRoute = '/auth/register';

  //Dashboard
  static String dashboardRoute = '/dashboard';
  static String marketingRoute = '/marketing';
  static String messageRoute =   '/message';

  static void configureRoutes () {
    // Auth Routes
    router.define (rootRoute, handler:      AdminHandlers.login   , transitionType: TransitionType.none);
    router.define (loginRoute, handler:     AdminHandlers.login   , transitionType: TransitionType.none);
    router.define (registerRoute, handler:  AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define (dashboardRoute, handler:   DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);

    router.define (marketingRoute, handler:   DashboardHandlers.marketing,  transitionType: TransitionType.fadeIn);
    router.define (messageRoute, handler:     DashboardHandlers.message,    transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }

}