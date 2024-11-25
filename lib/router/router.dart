

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

  static String ordersRoute           = '/dashboard/orders';
  static String ordersRecordsRoute    = '/dashboard/orders/records';
  static String ordersSearchCustomer  = '/dashboard/orders/customer';
  static String ordersSearchDate      = '/dashboard/orders/date';
  static String ordersSearchSales     = '/dashboard/orders/sales';
  static String ordersSearchDelivery  = '/dashboard/orders/delivery';
  static String ordersSearchRoute     = '/dashboard/orders/route';
  static String ordersNewOrder        = '/dashboard/orders/neworder';
  static String ordenRoute            = '/dashboard/orders/:id';

  static String paymentsRoute         = '/dashboard/payments';
  static String paymentRoute          = '/dashboard/payments/:id';

  static String gpsRoute        = '/dashboard/gps';

  static String productsRoute   = '/dashboard/products';
  static String productRoute    = '/dashboard/products/:id';

  static String categoriesRoute = '/dashboard/categories';

  static String customersRoute =    '/dashboard/customers';
  static String customerRoute =     '/dashboard/customers/:id';
  static String newCustomerRoute =  '/dashboard/newcustomer';
 
  static String routeRoutes =      '/dashboard/routes';
  static String routeRoute =      '/dashboard/routes/:id';

  static String zoneZones =     '/dashboard/zones';
  static String zoneZone =      '/dashboard/zones/:id';
  static String newRouteRoute = '/dashboard/newzone';

  // static String routes =   '/dashboard/routes';



  static String usersRoute      = '/dashboard/users';
  static String newUserRoute    = '/dashboard/users/newuser';

  static String marketingRoute  = '/dashboard/marketing';
  static String messageRoute    = '/dashboard/message';

  static String userRoute       = '/dashboard/users/:uid';


  static String settingsRoute         = '/dashboard/settings';
  static String inactiveUserRoute     = '/dashboard/settings/inactiveuser';
  static String financeRoute          = '/dashboard/settings/finance';
  static String taxSalesID            = '/dashboard/settings/finance/taxsales/:id';
  static String taxOperationID        = '/dashboard/settings/finance/taxoperation/:id';
  static String financeID             = '/dashboard/settings/finance/:id';
  static String bankRoute             = '/dashboard/settings/bankaccount';
  static String bankId                = '/dashboard/settings/bankaccount/:id';

  static String profile             = '/dashboard/settings/profile';
  static String profileId           = '/dashboard/settings/profile/:id';

  static void configureRoutes () {
    // Auth Routes
    router.define (rootRoute, handler:      AdminHandlers.login   , transitionType: TransitionType.none);
    router.define (loginRoute, handler:     AdminHandlers.login   , transitionType: TransitionType.none);
    router.define (registerRoute, handler:  AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define (dashboardRoute, handler:   DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);

    //Order
    router.define (ordersRoute,         handler:   DashboardHandlers.orders, transitionType: TransitionType.fadeIn);

    router.define (ordersRecordsRoute,    handler:   DashboardHandlers.ordersRecords, transitionType: TransitionType.fadeIn);
    
    router.define (ordersSearchCustomer,  handler:   DashboardHandlers.ordersCustomer, transitionType: TransitionType.fadeIn);
    router.define (ordersSearchDate,      handler:   DashboardHandlers.ordersDate, transitionType: TransitionType.fadeIn);
    router.define (ordersSearchSales,     handler:   DashboardHandlers.ordersSales, transitionType: TransitionType.fadeIn);
    router.define (ordersSearchDelivery,  handler:   DashboardHandlers.ordersDelivery, transitionType: TransitionType.fadeIn);
    router.define (ordersSearchRoute,     handler:   DashboardHandlers.ordersRoute, transitionType: TransitionType.fadeIn);
    router.define (ordersNewOrder,        handler:   DashboardHandlers.ordersNewOrder, transitionType: TransitionType.fadeIn);

    router.define (ordenRoute,          handler:   DashboardHandlers.orden, transitionType: TransitionType.fadeIn);

    // Payments
    router.define (paymentsRoute,       handler:   DashboardHandlers.payments, transitionType: TransitionType.fadeIn);
    router.define (paymentRoute,        handler:   DashboardHandlers.payment, transitionType: TransitionType.fadeIn);

    // GPS
    router.define (gpsRoute,        handler:  DashboardHandlers.gps,        transitionType: TransitionType.fadeIn);

    // Products
    router.define (productsRoute,   handler:  DashboardHandlers.products,   transitionType: TransitionType.fadeIn);    
    router.define (productRoute,    handler:  DashboardHandlers.product,    transitionType: TransitionType.fadeIn);   


    // Categories
    router.define (categoriesRoute, handler:  DashboardHandlers.categories, transitionType: TransitionType.fadeIn);


    // Customers
    router.define (customersRoute, handler:       DashboardHandlers.customers,            transitionType: TransitionType.fadeIn);
    router.define (customerRoute, handler:        DashboardHandlers.customer,             transitionType: TransitionType.fadeIn);
    router.define (newCustomerRoute, handler:     DashboardHandlers.newCustomer,         transitionType: TransitionType.fadeIn);
   
    // Users
    router.define (usersRoute, handler:       DashboardHandlers.users,            transitionType: TransitionType.fadeIn);
    router.define (newUserRoute, handler:     DashboardHandlers.newUserRegister,  transitionType: TransitionType.fadeIn);

    // Route
    router.define (routeRoutes, handler:       DashboardHandlers.routes,            transitionType: TransitionType.fadeIn);
    router.define (routeRoute, handler:        DashboardHandlers.route,             transitionType: TransitionType.fadeIn);

    // Zones
    router.define (zoneZones, handler:        DashboardHandlers.zones,            transitionType: TransitionType.fadeIn);
    router.define (zoneZone, handler:         DashboardHandlers.zone,             transitionType: TransitionType.fadeIn);
    // router.define (newRouteRoute, handler:     DashboardHandlers.newRoute,             transitionType: TransitionType.fadeIn);


    // Marketing
    router.define (marketingRoute, handler:   DashboardHandlers.marketing,  transitionType: TransitionType.fadeIn);

    // Message
    router.define (messageRoute, handler:     DashboardHandlers.message,    transitionType: TransitionType.fadeIn);

    // ELEMENTS 
    router.define (userRoute, handler:        DashboardHandlers.user,    transitionType: TransitionType.fadeIn);



    // Settings
    router.define (settingsRoute,     handler: DashboardHandlers.settings,           transitionType: TransitionType.fadeIn);
    router.define (inactiveUserRoute, handler: DashboardHandlers.inactiveUser,       transitionType: TransitionType.fadeIn);
    router.define (financeRoute,      handler: DashboardHandlers.finance,            transitionType: TransitionType.fadeIn);
    router.define (financeID,         handler: DashboardHandlers.financebyID,        transitionType: TransitionType.fadeIn);

    router.define (taxSalesID,         handler: DashboardHandlers.taxSalesbyID,      transitionType: TransitionType.fadeIn);
    router.define (taxOperationID,     handler: DashboardHandlers.taxOperationbyID,  transitionType: TransitionType.fadeIn);
    
    router.define (bankRoute,         handler: DashboardHandlers.bank,               transitionType: TransitionType.fadeIn);
    router.define (bankId,            handler: DashboardHandlers.bankID,             transitionType: TransitionType.fadeIn);
  

    // Profile
    router.define (profile,           handler: DashboardHandlers.profileSettings,  transitionType: TransitionType.fadeIn);
    router.define (profileId,         handler: DashboardHandlers.profile,          transitionType: TransitionType.fadeIn);


    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }

}