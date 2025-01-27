import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/datatables/payments_datasource.dart';
import 'package:web_dashboard/providers/auth_provider.dart';
import 'package:web_dashboard/providers/payments_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';


class PaymentsView extends StatefulWidget {
  const PaymentsView({super.key});

  @override
  State<PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {


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

    final paymentProvider = Provider.of<PaymentsProvider>(context);

    final paymentsDataSource = PaymentsDataSource( paymentProvider.payments );

    String todayDate = DateFormat('dd MM yy').format(DateTime.now());

    final activeUser = Provider.of<AuthProvider>(context).user!;
    



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
                child: Text('Payment View', style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
                    activeUser.rol != 'USER_ROLE' ? Container(
                       height: 50,
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton.icon(
                        onPressed: () async {
                          try {
              // Llama a la API
                    final response = await CafeApi.getJson('/ordercustomer/byDate/');

                    // Procesar datos si la respuesta es exitosa
                    final String base64Pdf = response['data'];
                    final Uint8List pdfBytes = base64Decode(base64Pdf); // Decodifica el Base64 a bytes

                    if (kIsWeb) {
                      // Lógica para descargar en la web
                      final blob = html.Blob([pdfBytes], 'application/pdf');
                      final url = html.Url.createObjectUrlFromBlob(blob);
                      final anchor = html.AnchorElement(href: url)
                        ..target = 'blank'
                        ..download = 'order_.pdf';
                      anchor.click();
                      html.Url.revokeObjectUrl(url);

                      NotificationService.showSnackBa('Order downloaded successfully.');
                    } else if (Platform.isAndroid || Platform.isIOS) {
                      // Lógica para móviles
                      final directory = await getApplicationDocumentsDirectory();
                      final filePath = '${directory.path}/order_.pdf';
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
                  todayDate,
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
            )
                    :  const SizedBox.shrink(),
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
                          'Create Payment',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                          NavigationService.replaceTo('/dashboard/payment/create');
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
          PaginatedDataTable(

            columns: const [
              DataColumn(label: Text('DATE')),
              DataColumn(label: Text('CONTROL')),
              DataColumn(label: Text('TYPE')),
              DataColumn(label: Text('CUSTOMER')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('AMOUNT')),
              DataColumn(label: Text('EDIT')),
            ],
            source: paymentsDataSource)
        ],
      )
    );
  }
}