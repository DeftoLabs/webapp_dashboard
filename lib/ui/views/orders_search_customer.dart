
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_searchdatedatasource.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

import '../../models/ordenes.dart';


class OrdersSearchCustomer extends StatefulWidget {
  const OrdersSearchCustomer({super.key});

  @override
  State<OrdersSearchCustomer> createState() => _OrdersSearchCustomerState();
}

class _OrdersSearchCustomerState extends State<OrdersSearchCustomer> {

  String? customerID;
  List<Ordenes> ordenes = [];


    @override
  void initState() {
    super.initState();
    Provider.of<CustomersProvider>(context, listen: false).getPaginatedCustomers();
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

    final ordersDataSource = OrdersSearchDateDataSource(ordenDateProvider.ordenes);

     final double screenWidth = MediaQuery.of(context).size.width;

     final localization = AppLocalizations.of(context)!;

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
                  localization.searchbycustomer,
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
                      color: const Color.fromARGB(255, 58, 60, 65),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                  children: [
                    Text(
                      localization.customer,
                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Consumer<CustomersProvider>(
                      builder: (context, customersProvider, child) {
                        if (customersProvider.isLoading) {
                          return CircularProgressIndicator(color: Colors.pink[300], strokeWidth: 2);
                        }
                        // DropdownButton con la lista de clientes
                        return DropdownButton<String>(
                          value: customerID,
                          hint: Text(localization.select, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white)),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          dropdownColor:  const Color.fromARGB(255, 145, 148, 154).withValues(alpha: 0.9),
                          items: customersProvider.customers.map((customer) {
                            return DropdownMenuItem<String>(
                              value: customer.id,
                              child: Row(
                                children: [
                                  Text(customer.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white)),
                                  const SizedBox(width: 5),
                                  Text(customer.sucursal, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.amber, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              customerID = newValue;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                   TextButton(
onPressed: () async {
  try {
    if (customerID == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withValues(alpha: 0.9),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localization.warning, style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            content: Text(localization.selectcustomermessage, style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black)),
          );
        },
      );
    } else {
      // Llama al método del Provider
      await context.read<OrdenDateProvider>().getOrdenByCustomer(customerID!);
    }
  } catch (e) {
    if (e.toString().contains(localization.nocustomerorder01)) {
if (context.mounted) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withValues(alpha: 0.9),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.noorder , style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
          ],
        ),
        content: Text(localization.nocustomerorder02, 
        style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black)),
      );
    },
  );
}
    } else {
      NotificationService.showSnackBarError(localization.nocustomerorder03);
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
    backgroundColor: const Color.fromRGBO(177, 255, 46, 1),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  ),
  child: Text(
    localization.search,
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
                      localization.noorderscustomer,
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
                    DataColumn(label: Text(localization.order ,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localization.date,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localization.deliverydate,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localization.customer,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localization.branch,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('STATUS',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localization.representative,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(localization.edit,style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                  source: ordersDataSource,
                  columnSpacing: screenWidth * 0.04,
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
  
  