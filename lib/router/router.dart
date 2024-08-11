

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
  static String dashboardRoute  = '/dashboard';

  static String gpsRoute        = '/dashboard/gps';

  static String productsRoute   = '/dashboard/products';
  static String productRoute   = '/dashboard/products/:id';

  static String categoriesRoute = '/dashboard/categories';

  static String customersRoute = '/dashboard/customers';


  static String usersRoute      = '/dashboard/users';
  static String newUserRoute    = '/dashboard/users/newuser';

  static String marketingRoute  = '/dashboard/marketing';
  static String messageRoute    = '/dashboard/message';

  static String userRoute       = '/dashboard/users/:uid';


  static String settingsRoute         = '/dashboard/settings';
  static String inactiveUserRoute     = '/dashboard/settings/inactiveuser';

  static void configureRoutes () {
    // Auth Routes
    router.define (rootRoute, handler:      AdminHandlers.login   , transitionType: TransitionType.none);
    router.define (loginRoute, handler:     AdminHandlers.login   , transitionType: TransitionType.none);
    router.define (registerRoute, handler:  AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define (dashboardRoute, handler:   DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);

    //Main

    // GPS
    router.define (gpsRoute,        handler:  DashboardHandlers.gps,        transitionType: TransitionType.fadeIn);

    // Products
    router.define (productsRoute,   handler:  DashboardHandlers.products,   transitionType: TransitionType.fadeIn);    
    router.define (productRoute,   handler:  DashboardHandlers.product,   transitionType: TransitionType.fadeIn);   

    // Categories
    router.define (categoriesRoute, handler:  DashboardHandlers.categories, transitionType: TransitionType.fadeIn);


    // Customers
    router.define (customersRoute, handler:  DashboardHandlers.customers, transitionType: TransitionType.fadeIn);

    // Users
    router.define (usersRoute, handler:       DashboardHandlers.users,            transitionType: TransitionType.fadeIn);
    router.define (newUserRoute, handler:     DashboardHandlers.newUserRegister,  transitionType: TransitionType.fadeIn);
    
    router.define (marketingRoute, handler:   DashboardHandlers.marketing,  transitionType: TransitionType.fadeIn);
    router.define (messageRoute, handler:     DashboardHandlers.message,    transitionType: TransitionType.fadeIn);

    // ELEMENTS 
    router.define (userRoute, handler:        DashboardHandlers.user,    transitionType: TransitionType.fadeIn);



    // CONFIGURATION
    router.define (settingsRoute, handler:     DashboardHandlers.settings,      transitionType: TransitionType.fadeIn);
    router.define (inactiveUserRoute, handler: DashboardHandlers.inactiveUser,  transitionType: TransitionType.fadeIn);


    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }

}