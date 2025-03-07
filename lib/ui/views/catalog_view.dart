
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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/notification_services.dart';


class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {

   final PageController _pageController = PageController();

  late Future<List<Producto>> productosFuture;

  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productosFuture = productProvider.obtenerProductos();
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

    final todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final localization = AppLocalizations.of(context)!;
    
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
                child: Text('', style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
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
        Center(
          child: 
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(localization.productcatalog,
          style: GoogleFonts.plusJakartaSans (
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                       height: 50,
                       width: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton.icon(
                         onPressed: () async {
                    try {
                      // Llama a la API
                      final response = await CafeApi.getJson('/productReport/listOfProduct');
                  
                      // Procesar datos si la respuesta es exitosa
                      final String base64Pdf = response['data'];
                      final Uint8List pdfBytes = base64Decode(base64Pdf); // Decodifica el Base64 a bytes
                  
                      if (kIsWeb) {
                        // Lógica para descargar en la web
                        final blob = html.Blob([pdfBytes], 'application/pdf');
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        final anchor = html.AnchorElement(href: url)
                          ..target = 'blank'
                          ..download = 'Product List $todayDate.pdf';
                        anchor.click();
                        html.Url.revokeObjectUrl(url);
                  
                        NotificationService.showSnackBa('Product List Downloaded Successfully.');
                      } else if (Platform.isAndroid || Platform.isIOS) {
                        // Lógica para móviles
                        final directory = await getApplicationDocumentsDirectory();
                        final filePath = '${directory.path}/Product List $todayDate.pdf';
                        final file = File(filePath);
                  
                        await file.writeAsBytes(pdfBytes);
                        await OpenFile.open(filePath);
                  
                        NotificationService.showSnackBa('Product List Downloaded Successfully.');
                      }
                    } on HttpException catch (e) {
                      if (e.message.contains('That date has no orders')) {
                        // Manejo específico del caso "That date has no orders"
                        NotificationService.showSnackBarError('No Product List Founded');
                      } else {
                        // Manejo genérico de otros errores HTTP
                        NotificationService.showSnackBarError('An error occurred while fetching the data. Please try again.');
                      }
                    } catch (e) {
                      // Manejo genérico para cualquier otro error
                      NotificationService.showSnackBarError('An unexpected error occurred. Please try again.');
                    }
                  },

                        icon: const Icon(Icons.share, color: Colors.black,),
                        label: Text(
                          'PDF LIST',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  Container(
                      height: 50,
                       width: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                        child: TextButton.icon(
                          onPressed: (){

                          }, 
                          icon: const Icon(Icons.book, color: Colors.black,),
                          label: Text(
                          'CATALOG',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),),
                  )
            ],
          ),
          const SizedBox(height: 40),
           SingleChildScrollView(
                     scrollDirection: Axis.vertical,
                     child: Container(
             width: double.infinity,
             color: const Color.fromARGB(255, 28, 28, 29),
             child: Column(children: [
               Container(
                   width: MediaQuery.of(context).size.width * 0.95,
                   padding: const EdgeInsets.all(16),
                   child: Column(children: [
                 
               
                     const SizedBox(height: 20),
                     Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           FutureBuilder<List<Producto>>(
                             future: productosFuture,
                             builder: (context, snapshot) {
                               int cantidadProductos = 0;
           
                               if (snapshot.hasData &&
                                   snapshot.data!.isNotEmpty) {
                                 cantidadProductos = snapshot.data!.length;
                               }
           
                               return Text(
                                 '${AppLocalizations.of(context)!.catalog} ($cantidadProductos)',
                                 style: GoogleFonts.plusJakartaSans(
                                     fontSize: 14,
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold),
                               );
                             },
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 25),
           
                     // PRODUCT VIEW
                     SizedBox(
                       height: 460,
                       child: FutureBuilder<List<Producto>>(
                         future: productosFuture,
                         builder: (context, snapshot) {
                           if (snapshot.connectionState ==
                               ConnectionState.waiting) {
                             return const Center(
                                 child: CircularProgressIndicator(color: Color.fromRGBO(177, 255, 46, 1), strokeWidth: 5));
                           }
           
                           if (snapshot.hasError) {
                             return Center(
                                 child: Text('Error: ${snapshot.error}'));
                           }
           
                           if (!snapshot.hasData || snapshot.data!.isEmpty) {
                             return Center(
                               child: Text(
                                 AppLocalizations.of(context)!
                                     .noproductsavailable,
                                 style: GoogleFonts.plusJakartaSans(
                                     fontSize: 14,
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold),
                               ),
                             );
                           }
           
                           final productos = snapshot.data!;
                           productos.sort((a, b) => a.descripcion!.compareTo(b.descripcion!));
           
                           return Column(
                             children: [
                               Expanded(
                                 child: PageView.builder(
                                   controller: _pageController,
                                   itemCount: productos.length,
                                   itemBuilder: (context, index) {
                                     final producto = productos[index];
                                     final image = (producto.img == null ||
                                             producto.img!.isEmpty)
                                         ? Image.asset('assets/noimage.jpeg',
                                             width: 300, height: 300)
                                         : FadeInImage.assetNetwork(
                                             placeholder: 'assets/load.gif',
                                             image: producto.img!,
                                             width: 300,
                                             height: 300,
                                             fit: BoxFit.fill,
                                             imageErrorBuilder:
                                                 (context, error, stackTrace) {
                                               return Image.asset(
                                                   'assets/noimage.jpeg',
                                                   width: 300,
                                                   height: 300);
                                             },
                                           );
           
                                     return Container(
                                       width:
                                           MediaQuery.of(context).size.width *
                                               0.8,
                                       height: 350,
                                       margin: const EdgeInsets.symmetric(
                                           horizontal: 10),
                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius:
                                             BorderRadius.circular(30),
                                       ),
                                       child: Column(
                                         mainAxisAlignment:
                                             MainAxisAlignment.center,
                                         children: [
                                           Padding(
                                             padding: const EdgeInsets.only(
                                                 right: 1),
                                             child: Row(
                                               mainAxisAlignment:
                                                   MainAxisAlignment.end,
                                               children: [
                                                 IconButton(
                                                   onPressed: () {
                                                     showDialog(
                                                       context: context,
                                                       builder: (BuildContext
                                                           context) {
                                                         return AlertDialog(
                                                           backgroundColor:
                                                               Colors.white,
                                                           title: Center(
                                                             child: Row(
                                                               mainAxisAlignment:
                                                                   MainAxisAlignment.end,
                                                               children: [
                                                                 Text(localization.nutricional,
                                                                   style: GoogleFonts.plusJakartaSans(
                                                                       fontSize: 14,
                                                                       color: Colors.black,
                                                                       fontWeight:FontWeight.bold),
                                                                 ),
                                                                 IconButton(
                                                                   onPressed:
                                                                       () {
                                                                     Navigator.of(context) .pop();
                                                                   },
                                                                   icon: const Icon( Icons.close),
                                                                 )
                                                               ],
                                                             ),
                                                           ),
                                                           content: SizedBox(
                                                             width: MediaQuery.of(context) .size .width * 0.7,
                                                             height: MediaQuery.of(context) .size .height * 0.4,
                                                             child:
                                                                 const Column(
                                                               mainAxisSize: MainAxisSize.min,
                                                               children: [
                                                                 // INFO O IMAGENES
                                                               ],
                                                             ),
                                                           ),
                                                         );
                                                       },
                                                     );
                                                   },
                                                   icon: const Icon(Icons.search_outlined),
                                                 )
                                               ],
                                             ),
                                           ),
                                           ClipRRect(
                                             borderRadius:
                                                 BorderRadius.circular(10),
                                             child: image,
                                           ),
                                           const SizedBox(height: 10),
                                           Text(
                                             producto.descripcion.toString(),
                                             style:
                                                 GoogleFonts.plusJakartaSans(
                                                     fontSize: 14,
                                                     color: Colors.black,
                                                     fontWeight:FontWeight.bold),
                                           ),
                                           const Divider(
                                             indent: 30,
                                             endIndent: 30,
                                             color: Colors.black,
                                           ),
                                           Text(
                                             'MARCA',
                                             style:
                                                 GoogleFonts.plusJakartaSans(
                                                     fontSize: 12,
                                                     color: Colors.black),
                                           ),
                                           const SizedBox(height: 20),
                                         ],
                                       ),
                                     );
                                   },
                                 ),
                               ),
                               const SizedBox(height:10), // Espaciado entre la lista y el indicador
                               SmoothPageIndicator(
                                 controller: _pageController,
                                 count: 5,
                                 effect: const ScrollingDotsEffect(
                                   activeDotColor:
                                       Color.fromRGBO(177, 255, 46, 1),
                                   dotColor: Colors.grey,
                                   dotHeight: 8,
                                   dotWidth: 8,
                                   spacing: 4,
                                   maxVisibleDots:
                                       5, // Limita la cantidad de puntos mostrados
                                 ),
                               ),
                             ],
                           );
                         },
                       ),
                     ),
           
                     const SizedBox(height: 30),
                  
                   ]))
             ])),
                   )
        ],
      )
        )

          

        ],
      )
    );
  }
}