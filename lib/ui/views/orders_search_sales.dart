
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_searchdatedatasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';


class OrdersSearchSales extends StatefulWidget {
  const OrdersSearchSales({super.key});

  @override
  State<OrdersSearchSales> createState() => _OrdersSearchSalesState();
}

class _OrdersSearchSalesState extends State<OrdersSearchSales> {

  String? usuarioZona;

    @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
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
                  'Orders View By Sales Representative',
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
                      'SALES REPRESENTIVE:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    const SizedBox(width: 10),
                    Consumer<UsersProvider>(
                      builder: (context, usersProvider, child) {
                        if (usersProvider.isLoading) {
                          return const CircularProgressIndicator(); // Mostrar indicador de carga
                        }
                        // DropdownButton con la lista de clientes
                        return DropdownButton<String>(
                          value: usuarioZona,
                          hint: Text('SELECT', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.black)),
                          items: usersProvider.users.map((user) {
                            return DropdownMenuItem<String>(
                              value: user.uid,
                              child: Text(user.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              usuarioZona = newValue;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                       TextButton(
                onPressed: () async {
  try {
    if (usuarioZona == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Warning', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            content: Text(
              'Please select a Sales Representative',
              style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
            ),
          );
        },
      );
    } else {
      await context.read<OrdenDateProvider>().getOrdenByRepresentative(usuarioZona!);
    }
  } catch (e) {
    if (e.toString().contains('Sales Representative With No Orders')) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No Orders',
                    style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              content: Text(
                'The Sales Representative currently has no Orders.',
                style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
              ),
            );
          },
        );
      }
    } else {
      NotificationService.showSnackBarError('Error with the Sales Representative Order');
    }
  }
},

                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  child: Text(
                    'SEARCH',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.black,
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
                      'NO ORDERS FOUND FOR THIS SALES REPRESENTATIVE',
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
                  //columnSpacing: screenWidth * 0.019,
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
  
  