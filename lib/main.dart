import 'package:flutter/material.dart';
// import 'dart:html' as html;

import 'package:universal_html/html.dart' as html;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'providers/providers.dart';
import 'api/cafeapi.dart';
import 'gps/blocs/blocs.dart';
import 'router/router.dart';
import 'services/local_storage.dart';
import 'services/navigation_service.dart';
import 'services/notification_services.dart';
import 'ui/layouts/auth/auth_layout.dart';
import 'ui/layouts/dashboard/dashboard_layout.dart';
import 'ui/layouts/splash/splash_layout.dart';

import 'package:flutter_localizations/flutter_localizations.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  

  final googleMapsScript = html.document.querySelector(
      'script[src*="https://maps.googleapis.com/maps/api/js"]');
  if (googleMapsScript == null) {
    final script = html.ScriptElement()
      ..src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyDH6RXeyIM_2m37JA6x_lV7p0XzGZlOH9E'
      ..async = true // Cargar de forma asincrónica
      ..defer = true;
    html.document.head!.append(script);
  }

  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  Flurorouter.configureRoutes();


  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => ProductFormProvider()),
        ChangeNotifierProvider(create: (_) => CustomersProvider()),
        ChangeNotifierProvider(create: (_) => CustomerFormProvider()),
        ChangeNotifierProvider(create: (_) => NewCustomerProvider()),
        ChangeNotifierProvider(create: (_) => ZonesProviders()),
        ChangeNotifierProvider(create: (_) => ZoneFormProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProfileFormProvider()),
        ChangeNotifierProvider(create: (_) => RutaProvider()),
        ChangeNotifierProvider(create: (_) => RutaFormProvider()),
        ChangeNotifierProvider(create: (_) => OrdenesProvider()),
        ChangeNotifierProvider(create: (_) => OrdenFormProvider()),
        ChangeNotifierProvider(create: (_) => OrdenDateProvider()),
        ChangeNotifierProvider(create: (_) => OrdenNewFormProvider()),
        ChangeNotifierProvider(create: (_) => FinanceProvider()),
        ChangeNotifierProvider(create: (_) => FinanceFormProvider()),
        ChangeNotifierProvider(create: (_) => BankProvider()),
        ChangeNotifierProvider(create: (_) => BankFormProvider()),
        ChangeNotifierProvider(create: (_) => TaxSalesProvider()),
        ChangeNotifierProvider(create: (_) => TaxSalesFormProvider()),
        ChangeNotifierProvider(create: (_) => TaxOperationProvider()),
        ChangeNotifierProvider(create: (_) => TaxOperationFormProvider()),
        ChangeNotifierProvider(create: (_) => PaymentsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentFormProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider())

        

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GpsBloc()),
          BlocProvider(create: (context) => LocationBloc()),
          BlocProvider(create: (context) => MapBloc()),
          
      
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bozz Web',
       locale: languageProvider.locale,
      supportedLocales: const [
        Locale('en'), // Inglés
        Locale('es'), // Español
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationService.messegerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}
