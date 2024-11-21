
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_searchdatedatasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';


class OrdersSearchRoute extends StatefulWidget {
  const OrdersSearchRoute({super.key});

  @override
  State<OrdersSearchRoute> createState() => _OrdersSearchRouteState();
}

class _OrdersSearchRouteState extends State<OrdersSearchRoute> {

  String? ruta;

    @override
  void initState() {
    super.initState();
    Provider.of<RutaProvider>(context, listen: false).getPaginatedRoutes();
  }

  @override
  Widget build(BuildContext context) {

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    final ordenDateProvider = Provider.of<OrdenDateProvider>(context);

      if (ordenDateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ordersDataSource = OrdersSearchDateDataSource(ordenDateProvider.ordenes);

     final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.replaceTo('/dashboard/orders');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  'Orders View By Route',
                  style: GoogleFonts.plusJakartaSans(fontSize: 22),
                )),
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
             const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                  children: [
                    Text(
                      'ROUTES:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    const SizedBox(width: 10),
                    Consumer<RutaProvider>(
                      builder: (context, rutaProvider, child) {
                        if (rutaProvider.isLoading) {
                          return const CircularProgressIndicator(); // Mostrar indicador de carga
                        }
                        // DropdownButton con la lista de clientes
                        return DropdownButton<String>(
                          value: ruta,
                          hint: Text('SELECT', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.black)),
                          items: rutaProvider.rutas.map((ruta) {
                            return DropdownMenuItem<String>(
                              value: ruta.id,
                              child: Text(ruta.nombreRuta, style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              ruta = newValue;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                      TextButton(
                              onPressed: () {
                                ruta == null ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Warning', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold)),
                                        IconButton(onPressed:(){
                                          Navigator.of(context).pop();
                                        }, 
                                        icon: const Icon(Icons.close))
                                      ],
                                    ),
                                    content: Text('Please select a Route', 
                                    style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black))
                                  );
                                },
                              )  : 
                            context.read<OrdenDateProvider>().getOrdenByRoute(ruta!);
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), 
                                ),
                                side: const BorderSide(
                                  color: Colors.black, // Color del borde
                                  width: 1, // Grosor del borde
                                ),
                                backgroundColor: Colors.grey[300], // Color de fondo del botón
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Espaciado interno
                              ),
                              child: Text('SEARCH', 
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: Colors.black, // Color para que parezca un botón interactivo
                                ),
                              ),
                            )
                  ],
                ),
          const SizedBox(height: 20),
          // Mostrar la tabla o el mensaje condicionalmente
          ordersDataSource.rowCount == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: Text(
                      'NO ORDERS FOUND FOR THIS CUSTOMER',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : PaginatedDataTable(
                  columns:[
                    DataColumn(label: Text('# ORDER',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('DATE',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('DELIVERY',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('CUSTOMER',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('BRANCH',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('STATUS',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('SALES',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('EDIT',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                  source: ordersDataSource,
                  columnSpacing: screenWidth * 0.019,
                ),
        ],
      ),
    ),
  ],
)


        ],
      )
    );
  }
}
  
  