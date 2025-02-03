import 'dart:convert';
import 'dart:io';

// ignore: avoid_web_libraries_in_flutter
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
  void initState() {
    super.initState();
    final paymentsProvider = Provider.of<PaymentsProvider>(context, listen: false);
    paymentsProvider.getPaginetedPayments();
  }


  @override
  Widget build(BuildContext context) {

    final paymentProvider = Provider.of<PaymentsProvider>(context);
    final paymentsDataSource = PaymentsDataSource( paymentProvider.payments );

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);


    String searchDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                            final response = await CafeApi.getJson('/paymentReport/byDate/$searchDate');
                            if (response.containsKey('data')) {
                              final base64Pdf = response['data'];
                        
                              if (base64Pdf is String && base64Pdf.isNotEmpty) {
                                final Uint8List pdfBytes = base64Decode(base64Pdf);
                                if (kIsWeb) {
                                  final blob = html.Blob([pdfBytes], 'application/pdf');
                                  final url = html.Url.createObjectUrlFromBlob(blob);
                                  final anchor = html.AnchorElement(href: url)
                                    ..target = 'blank'
                                    ..download = 'order_$searchDate.pdf';
                                  anchor.click();
                                  html.Url.revokeObjectUrl(url);
                        
                                  NotificationService.showSnackBa('Payment $searchDate Downloaded Successfully.');
                                } else if (Platform.isAndroid || Platform.isIOS) {
                                  final directory = await getApplicationDocumentsDirectory();
                                  final filePath = '${directory.path}/order_$searchDate.pdf';
                                  final file = File(filePath);
                                  await file.writeAsBytes(pdfBytes);
                                  await OpenFile.open(filePath);
                                  NotificationService.showSnackBa('Payment $searchDate Downloaded Successfully.');
                                }
                              } else {
                                NotificationService.showSnackBarError('Invalid data format.');
                              }
                            } else {
                              NotificationService.showSnackBarError('No data available for the requested date.');
                            }
                          } catch (e) {
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