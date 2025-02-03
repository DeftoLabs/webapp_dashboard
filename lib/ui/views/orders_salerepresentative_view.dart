import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_salesrepresentative_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class OrdersSaleRepresentativeView extends StatefulWidget {
  const OrdersSaleRepresentativeView({super.key});

  @override
  State<OrdersSaleRepresentativeView> createState() => _OrdersSaleRepresentativeViewState();
}

class _OrdersSaleRepresentativeViewState extends State<OrdersSaleRepresentativeView> {
  late OrdenDateProvider ordenDateProvider;

@override
void initState() {
  super.initState();
  ordenDateProvider = Provider.of<OrdenDateProvider>(context, listen: false);
  
  // Usamos addPostFrameCallback para asegurarnos de que la carga de órdenes
  // se haga después de la construcción del widget
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadOrders();
  });
}

void _loadOrders() async {
  final currentUser = Provider.of<AuthProvider>(context, listen: false).user;

  if (currentUser != null) {
    // Limpiamos las órdenes antes de cargarlas
    ordenDateProvider.clearOrders();
    
    // Llamada asincrónica a getOrdenByRepresentative
    try {
      await ordenDateProvider.getOrdenByRepresentative(currentUser.uid);
    } catch (error) {
      debugPrint('Error al obtener órdenes: $error');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final ordenDateProvider = Provider.of<OrdenDateProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    if (authProvider.user == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(255, 0, 200, 0.612),
          strokeWidth: 4.0,
        ),
      );
    }

    final currentUser = authProvider.user!;
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (ordenDateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final image = (profile?.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile!.img!, width: 35, height: 35);

    final ordersDataSource = OrdersSalesRepresentativeDataSource(ordenDateProvider.ordenes);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text('Welcome ${currentUser.nombre}', style: GoogleFonts.plusJakartaSans(fontSize: 22)
                ),
              ),
              Container(
                height: 50,
                width: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(177, 255, 46, 100),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 0.6,
                  )
                ),
                child: TextButton(
                  child: Text(
                    'Create Order',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceTo('/dashboard/orderbyrepresentative/createorder');
                  },
                ),
              ),
              const SizedBox(width: 50),
              SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ordersDataSource.rowCount == 0
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 200),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'NO ORDERS FOUND FOR: ',
                                    style: TextStyle(fontWeight: FontWeight.normal),
                                  ),
                                  TextSpan(
                                    text: currentUser.nombre,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : PaginatedDataTable(
                          columns: [
                            DataColumn(label: Text('# ORDER', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('DATE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('CUSTOMER', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('BRANCH', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('STATUS', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('EDIT', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                          ],
                          source: ordersDataSource,
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
