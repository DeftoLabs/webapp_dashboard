import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            const SizedBox(height: 20),
            Column(
              children: [
                PaginatedDataTable(
                  header: Text(
                    'Order Records',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  columns: [
                    DataColumn(label: 
                    Text('# ORDER', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('DATE',style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('DELIVERY', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('CUSTOMER', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('BRANCH', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('STATUS', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('SALES', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)), ),
                    DataColumn(label: Text('EDIT', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                  source: ordersDataSource,
                  columnSpacing: screenWidth * 0.015,
                  //rowsPerPage: 5,
                  onPageChanged: (page) {},
                ),
              ],
            )
          ],
        ));
  }
}
