import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/sidemenu_provider.dart';
import 'package:web_dashboard/gps/view_gps/gps_screen.dart';
import 'package:web_dashboard/ui/modals/taxoperation_modal.dart';
import 'package:web_dashboard/ui/modals/taxsale_modal.dart';
import 'package:web_dashboard/ui/views/analityc_view.dart';
import 'package:web_dashboard/ui/views/bank_view.dart';
import 'package:web_dashboard/ui/views/banks_view.dart';
import 'package:web_dashboard/ui/views/catalog_view.dart';
import 'package:web_dashboard/ui/views/finance_view.dart';
import 'package:web_dashboard/ui/views/finances_view.dart';
import 'package:web_dashboard/ui/views/no_page_access_view.dart';
import 'package:web_dashboard/ui/views/orden_view.dart';
import 'package:web_dashboard/ui/views/orders_newsalesrepresentative.dart';
import 'package:web_dashboard/ui/views/orders_salerepresentative_view.dart';
import 'package:web_dashboard/ui/views/orders_search_customer.dart';
import 'package:web_dashboard/ui/views/orders_search_date.dart';
import 'package:web_dashboard/ui/views/orders_search_product.dart';
import 'package:web_dashboard/ui/views/orders_neworden.dart';
import 'package:web_dashboard/ui/views/orders_records_view.dart';
import 'package:web_dashboard/ui/views/orders_search_route.dart';
import 'package:web_dashboard/ui/views/orders_search_sales.dart';
import 'package:web_dashboard/ui/views/payment_new_salesrepresentative_view.dart';
import 'package:web_dashboard/ui/views/payment_new_view.dart';
import 'package:web_dashboard/ui/views/payment_view.dart';
import 'package:web_dashboard/ui/views/payments_salesrepresentative_view.dart';
import 'package:web_dashboard/ui/views/payments_view.dart';
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
import 'package:web_dashboard/ui/views/shipment_view.dart';
import 'package:web_dashboard/ui/views/support_view.dart';
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

  // Analityc 
    static Handler analityc = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.analitycRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
       if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const AnalitycView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

   // ACCESS TO ADMIN_ROLE AND MASTER_ROL
    static Handler orders = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );
  // ACCESS TO USER_ROLE

      static Handler ordersbyrepresentative = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if(authProvider.user?.rol == 'USER_ROLE') {
        return const OrdersSaleRepresentativeView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

      static Handler ordersRecords = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersRecordsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersRecordsView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

  static Handler ordersCustomer = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersSearchCustomer);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersSearchCustomer();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler ordersDate = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersSearchDate);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersSearchDate();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

     static Handler ordersSales = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersSearchSales);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersSearchSales();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

  static Handler ordersDelivery = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersSearchDelivery);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersSearchProduct();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

  static Handler ordersRoute = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersSearchRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersSearchRoute();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

  static Handler ordersNewOrder = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersNewOrder);
      if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const OrdersNewOrdern();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler ordersNewSales = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersNewSalesRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
      if(authProvider.user?.rol == 'USER_ROLE') {
        return const OrdersNewSalesRepresentative();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

  static Handler orden = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordenRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
        if (params['id']?.first != null) {
          return OrdenView(id: params['id']!.first);
        } else {
          return const OrdersView();
      }
    } return const LoginView();

    }
  );

    // Shipment 
    static Handler shipment = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.shipmentRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const ShipmentView();
      } return const LoginView();

    }
  );

  static Handler payments = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.paymentsRoute);
   if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const PaymentsView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler payment = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.paymentRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if( params['id']?.first !=null){
           return PaymentView(id: params['id']!.first);
        }else{
          return const PaymentsView();
        }
      } return const LoginView();

    }
  );

    static Handler newPayment = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.newPaymentRoute);
     if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const PaymentNewView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler paymentsbyrepresentative = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.ordersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if(authProvider.user?.rol == 'USER_ROLE') {
        return const PaymentsSalesRepresentativeView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

      static Handler newSalesPayment = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.paymentsNewSalesRoute);
     if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'USER_ROLE') {
        return const PaymentNewSalesRepresentativeView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );


    static Handler gps = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.gpsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const GpsScreen();
        } else {
          return const NoPageAccessView();
        }
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

  // Catalog
    static Handler catalog = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.shipmentRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const CatalogView();
      } return const LoginView();

    }
  );

  static Handler categories = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.categoriesRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const CategoriesView();
        } else {
          return const NoPageAccessView();
        }
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
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const RutasView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

static Handler route = Handler(
  handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.routeRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return RutaView(id: params['id']!.first);
        } else {
          return const RutasView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
  },
);



    static Handler zones = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.zoneZones);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const ZonesView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler zone = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.zoneZone);
  if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return ZoneView(id: params['id']!.first);
        } else {
          return const ZonesView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
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

  static Handler support = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.supportRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        return const SupportView();
      } return const LoginView();

    }
  );


  static Handler users = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.usersRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const UsersView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  ); 


  static Handler user = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.userRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if ( params ['uid']?.first != null ) {
          return UserView(uid: params ['uid']!.first);
        }else {
          return const UsersView();
      } 
      } else {
        return const NoPageAccessView();
    }
    }
     return const LoginView();
    }
  ); 


    static Handler newUserRegister = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.newUserRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const NewUserRegister();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );




  // Configuration

    static Handler settings = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.settingsRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
       if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const SettingsView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

      static Handler profileSettings = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.profile);
      if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const ProfilesView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();
    }
  );

    static Handler profile = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.profileId);
  if (authProvider.authStatus == AuthStatus.authenticated) {
       if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return ProfileView(id: params['id']!.first);
        } else {
          return const ProfilesView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
    }
  );


    static Handler inactiveUser = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.inactiveUserRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const InactiveUserView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler finance = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.financeRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
         if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const FinancesView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );

    static Handler financebyID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.financeID);
  if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return FinanceView(id: params['id']!.first);
        } else {
          return const FinancesView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
    }
  );

      static Handler taxSalesbyID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.taxSalesID);
  if (authProvider.authStatus == AuthStatus.authenticated) {
       if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return TaxSaleView(id: params['id']!.first);
        } else {
          return const FinancesView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
    }
  );


  static Handler taxOperationbyID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.taxOperationID);
  if (authProvider.authStatus == AuthStatus.authenticated) {
       if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return TaxOperationModal(id: params['id']!.first);
        } else {
          return const FinancesView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
    }
  );
  
  static Handler bank = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.bankRoute);
      if( authProvider.authStatus == AuthStatus.authenticated) {
        if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        return const BanksView();
        } else {
          return const NoPageAccessView();
        }
      } return const LoginView();

    }
  );
      static Handler bankID = Handler (
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.bankId);
  if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user?.rol == 'ADMIN_ROLE' || authProvider.user?.rol == 'MASTER_ROL') {
        if (params['id']?.first != null) {
          return BankView(id: params['id']!.first);
        } else {
          return const BanksView();
        }
      } else {
        return const NoPageAccessView();
      }
    }
    return const LoginView();
    }
  );

}

