// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/payment.dart';
import 'package:web_dashboard/providers/payment_form_provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';


class PaymentView extends StatefulWidget {

  final String id;

  const PaymentView({super.key, required this.id});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  Payment? payment;

  @override
  void initState() {
    super.initState();
    final paymentsProvider = Provider.of<PaymentsProvider>(context, listen: false);
    final paymentFormProvider = Provider.of<PaymentFormProvider>(context, listen: false);

    paymentsProvider.getPaymentsByID(widget.id)
    .then((paymentDB) {
        paymentFormProvider.payment = paymentDB;
        setState(() { payment = paymentDB;  });
        
      
    }
    
    );
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Row(
                children: [
                  IconButton(
                      color: Colors.black,
                      onPressed: () {
                        NavigationService.navigateTo('/dashboard/payments');
                      },
                      icon: const Icon(Icons.arrow_back_rounded)),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'PAYMENT DETAILS',
                          style: GoogleFonts.plusJakartaSans(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),

          const SizedBox(height: 10),
        ],
      ), 
      const SizedBox(height: 10),
      const Divider(),
      const SizedBox(height: 10),
         if (payment == null)
              WhiteCard(
                child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                color: Color.fromRGBO(255, 0, 200, 0.612),
                strokeWidth: 4.0),
              )
              ),
              if (payment != null) ...[
              const SizedBox(height: 10),
              const PaymentViewBody(),
              const SizedBox(height: 10),
            
            ]

            
    ]
    )
    );
  }
}

class PaymentViewBody extends StatelessWidget {
  const PaymentViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return const Column(
      children: [
        PaymentViewForm(),
        AttachViewBody()
      ],
    );
  }
}

class PaymentViewForm extends StatelessWidget {

  
  const PaymentViewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final paymentFormProvider = Provider.of<PaymentFormProvider>(context);
    final payment = paymentFormProvider.payment!;

    return WhiteCard(
      width: MediaQuery.of(context).size.width,
      child: 
      Form(
        // key: 
        child:
        Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 300,
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(payment.numerocontrol, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 40),
                            Text(DateFormat('dd/MM/yy').format(payment.fechacreacion), style: GoogleFonts.plusJakartaSans(fontSize: 14))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('CUSTOMER', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        Text(payment.cliente.razons, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text('DETAIL', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        Text(payment.comentarios, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('METHOD: ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text(payment.type, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text('COLLECTED BY: ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text(payment.usuario.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                     ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('AMOUNT ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text(payment.currencySymbol, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 5),
                            Text(payment.monto.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('BANK ', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text(payment.bancoemisor, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('PAYMENT DATE', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                           Text(DateFormat('dd/MM/yy').format(payment.fechapago), style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                             Text('REF', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text(payment.numeroref, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('RECEIVING BANK', style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                            const SizedBox(width: 20),
                            Text(payment.bancoreceptor.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
                 Container(
                 height: 50,
                 width: 150,
                 padding: const EdgeInsets.all(10),
                 decoration: BoxDecoration(
                     color: Colors.black,
                     borderRadius: BorderRadius.circular(20),),
                 child: TextButton(
                   child: Text(
                     'DOWNLOAD',
                     style: GoogleFonts.plusJakartaSans(
                         color: Colors.white,
                         fontWeight: FontWeight.bold),
                   ),
                   
                   onPressed: () async {
                     try {
                       // Llama a la API y obtiene la respuesta
                       final response = await CafeApi.getJson('/paymentReport/${payment.id}');
                 
                       // Extrae los datos codificados en Base64
                       final String base64Pdf = response['data'];
                       final Uint8List pdfBytes = base64Decode(base64Pdf); // Decodifica el Base64 a bytes
                 
                       // Lógica para guardar el PDF dependiendo de la plataforma
                       if (kIsWeb) {
                         // WEB: Descarga el PDF
                         final blob = html.Blob([pdfBytes], 'application/pdf');
                         final url = html.Url.createObjectUrlFromBlob(blob);
                 
                         final anchor = html.AnchorElement(href: url)
                           ..target = 'blank'
                           ..download = 'payment_${payment.id}.pdf';
                         anchor.click();
                 
                         html.Url.revokeObjectUrl(url);
                          NotificationService.showSnackBa('Download Payment');
                       } else if (Platform.isAndroid || Platform.isIOS) {
                         // MÓVILES: Guarda y abre el archivo PDF
                         final directory = await getApplicationDocumentsDirectory();
                         final filePath = '${directory.path}/payment_${payment.id}.pdf';
                         final file = File(filePath);
                 
                         await file.writeAsBytes(pdfBytes);
                         await OpenFile.open(filePath); // Abre el archivo
                         NotificationService.showSnackBa('Download Order');
                       } else {
                         throw UnsupportedError('Platform Not Supported');
                       }
                     } catch (e) {
                       NotificationService.showSnackBarError('Invalid data. Please Contact Customer Service.');
                     }
                   }
                                   ),
                                   ),
                    const SizedBox(height: 20),
                         ],
                       )
      ),

    );
  }
}

class AttachViewBody extends StatelessWidget {
  
  const AttachViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final paymentFormProvider = Provider.of<PaymentFormProvider>(context);
    final payment = paymentFormProvider.payment!;

    final image = (payment.img == null || payment.img!.isEmpty) ? 
    const Image(image: AssetImage('nofile.png')) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: payment.img!, fit: BoxFit.cover);

    return WhiteCard(
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ATTACHED FILE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold), ),
                const SizedBox(width: 30),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: image,
            ),
             const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
  