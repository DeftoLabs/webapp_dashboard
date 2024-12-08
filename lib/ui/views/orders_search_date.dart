
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_searchdatedatasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';


class OrdersSearchDate extends StatefulWidget {
  const OrdersSearchDate({super.key});

  @override
  State<OrdersSearchDate> createState() => _OrdersSearchDateState();
}

class _OrdersSearchDateState extends State<OrdersSearchDate> {

  DateTime? fechaentrega;
  DateTime? fechacreado;

    @override
  void initState() {
    super.initState();
    final ordenDateProvider = Provider.of<OrdenDateProvider>(context, listen: false);
    ordenDateProvider.getOrdenByDay();
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
                  'Orders View By Date',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                              children: [
                                Text(
                                  'DELIVERY DATE:',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                                ),
                                const SizedBox(width: 5),
                                IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    DateTime now = DateTime.now();
                                    // Abrir el selector de fechas
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: fechaentrega != null && fechaentrega!.isAfter(now)
                                          ? fechaentrega!
                                          : now,
                                      firstDate:DateTime(2024), 
                                      lastDate: DateTime(2101), 
                                      builder: (BuildContext context, Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            primaryColor: Colors.black,
                                            hintColor: Colors.black,
                                            colorScheme: const ColorScheme.light(primary: Colors.black),
                                            buttonTheme:
                                                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    )                       ;
                         
                                    // Actualizar la fecha seleccionada
                                    if (pickedDate != null) {
                                      setState(() {
                                        fechaentrega = pickedDate;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                fechaentrega != null
                                    ? DateFormat('dd/MM/yy').format(fechaentrega!) // Formato de la fecha seleccionada
                                    : '', // Texto por defecto
                               
                              ),
                              const SizedBox(width: 10),
                        TextButton(
                          onPressed: () async {
                            if (fechaentrega == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                     backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                                    title: Text(
                                      'Warning',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Please select a Delivery Date',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK', style: GoogleFonts.plusJakartaSans()),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Llama al método del Provider
                              await context.read<OrdenDateProvider>().getOrdenByDaySearch(fechaentrega!);

                              // Verifica si el widget sigue montado antes de usar el contexto
                              if (!mounted) return;

                              // Si no hay órdenes, muestra el diálogo
                              if (context.mounted) {
                              if (context.read<OrdenDateProvider>().ordenes.isEmpty) {
                                if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                       backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                                      title: Text(
                                        'No Orders Found',
                                        style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'No orders were found for the selected date.',
                                        style: GoogleFonts.plusJakartaSans(fontSize: 18),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: GoogleFonts.plusJakartaSans(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }}}
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

                              Row(
                              children: [
                                Text(
                                  'CREATE DATE:',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                                ),
                                const SizedBox(width: 5),
                                IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    DateTime now = DateTime.now();
                                    // Abrir el selector de fechas
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: fechacreado != null && fechacreado!.isAfter(now)
                                          ? fechacreado!
                                          : now,
                                      firstDate:DateTime(2024), 
                                      lastDate: now, 
                                      builder: (BuildContext context, Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            primaryColor: Colors.black,
                                            hintColor: Colors.black,
                                            colorScheme: const ColorScheme.light(primary: Colors.black),
                                            buttonTheme:
                                                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    )                       ;
                         
                                    // Actualizar la fecha seleccionada
                                    if (pickedDate != null) {
                                      setState(() {
                                        fechacreado = pickedDate;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                fechacreado != null
                                    ? DateFormat('dd/MM/yy').format(fechacreado!) // Formato de la fecha seleccionada
                                    : '', // Texto por defecto
                               
                              ),
                              const SizedBox(width: 10),
                        TextButton(
                          onPressed: () async {
                            if (fechacreado == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                     backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                                    title: Text(
                                      'Warning',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Please select a Created Date',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK', style: GoogleFonts.plusJakartaSans()),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Llama al método del Provider
                              await context.read<OrdenDateProvider>().getOrdenByDayCreate(fechacreado!);

                              // Verifica si el widget sigue montado antes de usar el contexto
                              if (!mounted) return;

                              // Si no hay órdenes, muestra el diálogo
                              if (context.mounted) {
                              if (context.read<OrdenDateProvider>().ordenes.isEmpty) {
                                if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                       backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                                      title: Text(
                                        'No Orders Found',
                                        style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'No orders were found for the selected date.',
                                        style: GoogleFonts.plusJakartaSans(fontSize: 18),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: GoogleFonts.plusJakartaSans(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }}}
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
                       ],
                     ),
          const SizedBox(height: 20),
          // Mostrar la tabla o el mensaje condicionalmente
          ordersDataSource.rowCount == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: Text(
                      'NO ORDERS FOUND FOR THIS DATE',
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
  
  