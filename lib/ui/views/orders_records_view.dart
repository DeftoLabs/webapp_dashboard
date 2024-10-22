import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_records_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class OrdersRecordsView extends StatefulWidget {
  const OrdersRecordsView({super.key});

  @override
  State<OrdersRecordsView> createState() => _OrdersRecordsViewState();
}

class _OrdersRecordsViewState extends State<OrdersRecordsView> {
  DateTime? selectedDate;
  String? selectedStatus;
  String? selectedSales;
  String? selectedClient;

  final List<String> statusOptions = [
    'ORDER',
    'APPROVED',
    'CANCEL',
    'INVOICE',
    'NOTE'
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty
        ? profileProvider.profiles[0]
        : null;

    final ordenesProvider = Provider.of<OrdenesProvider>(context);

    if (profile == null) {
      return const Center(child: Text(''));
    }

    final image = (profile.img == null)
        ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'load.gif',
            image: profile.img!,
            width: 35,
            height: 35);

    final ordersDataSource = OrdersRecordsDataSource(ordenesProvider.ordenes);

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
                  'Orders Records',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Search Options',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 20),
            Container(
                height: 260,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text('Search by Sales Representative'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2040));
                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                });
                              }
                            },
                            child: Text(selectedDate != null
                                ? DateFormat('yyy-MM-dd').format(selectedDate!)
                                : 'Select Date')),
                        DropdownButton<String>(
                            value: selectedStatus,
                            hint: const Text('Select Status'),
                            items: statusOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedStatus = newValue;
                              });
                            }),
                        SizedBox(
                          width: 400,
                          child: Consumer<OrdenesProvider>(
                            builder: (context, ordenesProvider, child) {
                              if (ordenesProvider.ordenes.isEmpty) {
                                return const Text('No Orders Available');
                              }

                              // Obtener usuarios sin duplicados
                              List<String> usuariosZona = ordenesProvider
                                  .ordenes
                                  .map((orden) =>
                                      orden.ruta.first.usuarioZona.nombre)
                                  .toSet()
                                  .toList();

                              return DropdownButton<String>(
                                value: selectedSales,
                                hint: const Text(
                                    'Sales Representative'), // Texto sugerido
                                items: usuariosZona.map((nombre) {
                                  return DropdownMenuItem<String>(
                                    value: nombre,
                                    child: Text(nombre),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedSales = newValue;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text('Search by Customer'),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2040));
                                  if (picked != null &&
                                      picked != selectedDate) {
                                    setState(() {
                                      selectedDate = picked;
                                    });
                                  }
                                },
                                child: Text(selectedDate != null
                                    ? DateFormat('yyy-MM-dd')
                                        .format(selectedDate!)
                                    : 'Select Date')),
                            DropdownButton<String>(
                                value: selectedStatus,
                                hint: const Text('Select Status'),
                                items: statusOptions.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedStatus = newValue;
                                  });
                                }),
                            SizedBox(
                              width: 400,
                              child: Consumer<OrdenesProvider>(
                                builder: (context, ordenesProvider, child) {
                                  if (ordenesProvider.ordenes.isEmpty) {
                                    return const Text('No Orders Available');
                                  }

                                  // Obtener usuarios sin duplicados
                                  List<String> clientes = ordenesProvider
                                      .ordenes
                                      .where(
                                          (orden) => orden.clientes.isNotEmpty)
                                      .map((orden) =>
                                          orden.clientes.first.nombre)
                                      .toSet()
                                      .toList();

                                  return DropdownButton<String>(
                                    value: selectedClient,
                                    hint: const Text(
                                        'Select Client'), // Texto sugerido
                                    items: clientes.map((nombre) {
                                      return DropdownMenuItem<String>(
                                        value: nombre,
                                        child: Text(nombre),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedClient = newValue;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search)),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            Column(
              children: [
                PaginatedDataTable(
                  sortAscending: ordenesProvider.ascending,
                  sortColumnIndex: ordenesProvider.sortColumnIndex,
                  header: Text(
                    'Order Records',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  columns: [
                    const DataColumn(label: Text('# Order')),
                    DataColumn(
                        label: const Text('Date'),
                        onSort: (colIndex, _) {
                          ordenesProvider.sortColumnIndex = colIndex;
                          ordenesProvider
                              .sort<DateTime>((ordenes) => ordenes.fechacreado);
                        }),
                    DataColumn(
                        label: const Text('Customer'),
                        onSort: (colIndex, _) {
                          ordenesProvider.sortColumnIndex = colIndex;
                          ordenesProvider.sort<String>((ordenes) =>
                              ordenes.clientes.isNotEmpty
                                  ? ordenes.clientes.first.nombre
                                  : '');
                        }),
                    DataColumn(
                        label: const Text('Status'),
                        onSort: (colIndex, _) {
                          ordenesProvider.sortColumnIndex = colIndex;
                          ordenesProvider
                              .sort<String>((ordenes) => ordenes.status);
                        }),
                    DataColumn(
                        label: const Text('Sales'), onSort: (colIndex, _) {}),
                    const DataColumn(label: Text('Edit')),
                  ],
                  source: ordersDataSource,
                  columnSpacing: screenWidth * 0.05,
                  rowsPerPage: 5,
                  onPageChanged: (page) {},
                ),
              ],
            )
          ],
        ));
  }
}
