import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/datatables/orders_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/rectangular_card.dart';



class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
 


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

    String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
    String todayDateII = DateFormat('dd/MM/yy').format(DateTime.now());
    String searchDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final ordenDateProvider = Provider.of<OrdenDateProvider>(context);
    // final ordenProvider = Provider.of<OrdenesProvider>(context);

      if (ordenDateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ordersDataSource = OrdersDateDataSource( ordenDateProvider.ordenes );

     final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded
              (
                child: Text('ORDERS VIEW', style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
                ordersDataSource.rowCount > 0 ?
               Container(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton.icon(
                 onPressed: () async {
                    try {
                      // Llama a la API
                      final response = await CafeApi.getJson('/ordercustomer/byDate/$searchDate');
                  
                      // Procesar datos si la respuesta es exitosa
                      final String base64Pdf = response['data'];
                      final Uint8List pdfBytes = base64Decode(base64Pdf); // Decodifica el Base64 a bytes
                  
                      if (kIsWeb) {
                        // Lógica para descargar en la web
                        final blob = html.Blob([pdfBytes], 'application/pdf');
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        final anchor = html.AnchorElement(href: url)
                          ..target = 'blank'
                          ..download = 'order_$searchDate.pdf';
                        anchor.click();
                        html.Url.revokeObjectUrl(url);
                  
                        NotificationService.showSnackBa('Order downloaded successfully.');
                      } else if (Platform.isAndroid || Platform.isIOS) {
                        // Lógica para móviles
                        final directory = await getApplicationDocumentsDirectory();
                        final filePath = '${directory.path}/order_$searchDate.pdf';
                        final file = File(filePath);
                  
                        await file.writeAsBytes(pdfBytes);
                        await OpenFile.open(filePath);
                  
                        NotificationService.showSnackBa('Order downloaded successfully.');
                      }
                    } on HttpException catch (e) {
                      if (e.message.contains('That date has no orders')) {
                        // Manejo específico del caso "That date has no orders"
                        NotificationService.showSnackBarError('No orders found for the requested date.');
                      } else {
                        // Manejo genérico de otros errores HTTP
                        NotificationService.showSnackBarError('An error occurred while fetching the data. Please try again.');
                      }
                    } catch (e) {
                      // Manejo genérico para cualquier otro error
                      NotificationService.showSnackBarError('An unexpected error occurred. Please try again.');
                    }
                  },

          label: Text(
            todayDateII,
            style: GoogleFonts.plusJakartaSans(color: Colors.white),
          ),
          icon: const Icon(
            Icons.download_rounded,
            color: Colors.white,
            size: 24,
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ) : const SizedBox.shrink(),
                  const SizedBox(width: 20),
                Container(
                       height: 50,
                       width: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton(
                        child: Text(
                          'Create Order',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                         NavigationService.replaceTo('/dashboard/orders/neworder');
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
    Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: 540,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order of the Day - $todayDate',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Mostrar la tabla o el mensaje condicionalmente
          ordersDataSource.rowCount == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: Text(
                      'NO ORDERS RECEIVED FOR TODAY',
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
                  rowsPerPage: 7,
                ),
        ],
      ),
    ),
    const SizedBox(height: 20),
    const OrdersScrollRow(),
    const SizedBox(height: 20),
  ],
)


        ],
      )
    );
  }
}

class OrdersScrollRow extends StatefulWidget {
  const OrdersScrollRow({super.key});

  @override
  OrdersScrollRowState createState() => OrdersScrollRowState();
}

class OrdersScrollRowState extends State<OrdersScrollRow> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset - 300, // Scroll hacia la izquierda
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 300, // Scroll hacia la derecha
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RectangularCard(
                title: 'Order Records',
                width: 200,
                child: const Center(child: Icon(Icons.push_pin_rounded)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/records');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Search By Customer',
                width: 200,
                child: const Center(child: Icon(Icons.add_business_sharp)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/customer');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Search By Date',
                width: 200,
                child: const Center(child: Icon(Icons.date_range_rounded)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/date');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Search By Sales',
                width: 200,
                child: const Center(child: Icon(Icons.person_outline_rounded)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/sales');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Search By Product',
                width: 200,
                child: const Center(child: Icon(Icons.add_box_outlined)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/delivery');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Search By Route',
                width: 200,
                child: const Center(child: Icon(Icons.add_box_outlined)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/route');
                },
              ),
            ],
          ),
        ),
        // Flecha hacia la izquierda
        Positioned(
          left: 25,
          top: 0,
          bottom: 0,
          child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle
              ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _scrollLeft,
              ),
            ),
          ),
        ),
        // Flecha hacia la derecha
        Positioned(
          right: 25,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: _scrollRight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
