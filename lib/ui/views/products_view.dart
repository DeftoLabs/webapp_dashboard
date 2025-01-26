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
import 'package:web_dashboard/datatables/products_datasource.dart';
import 'package:web_dashboard/providers/products_provider.dart';
import 'package:web_dashboard/providers/profile_provider.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/modals/product_new_modal.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productDataSource = ProductsDTS(productsProvider.productos, context);

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    final todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
             Row(
            children: [
              const SizedBox(width: 20),
              Expanded
              (
                child: Text('PRODUCTS VIEW', style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.bold),)),
                  const SizedBox(width: 20),
                Container(
                       height: 50,
                       width: 140,
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
            const SizedBox(height: 10),
            PaginatedDataTable(
              sortAscending: productsProvider.ascending,
              sortColumnIndex: productsProvider.sortColumnIndex,
              columns: [
                const DataColumn(
                  label: Text('Image'),
                ),
                const DataColumn(
                  label: Text('Code'),
                ),
                DataColumn(label: const Text('Description'), onSort: (colIndex, _) {
                  productsProvider.sortColumnIndex = colIndex;
                  productsProvider.sort((producto) => producto.descripcion.toString());
                }),
                DataColumn(label: const Text('Stock'), onSort: (colIndex, _) {
                  productsProvider.sortColumnIndex = colIndex;
                  productsProvider.sort((producto) => producto.stock);
                }),
                const DataColumn(label: Text('Unit')),
                
                DataColumn(label: const Text('Price'), onSort: (colIndex, _) {
                  productsProvider.sortColumnIndex = colIndex;
                  productsProvider.sort((producto) => producto.precio1);
                }),
                const DataColumn(label: Text('Categories')),
                const DataColumn(label: Text('Actions')),
              ],
              source: productDataSource,
              header: Text(' LIST OF PRODUCTS', maxLines: 2, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold),),
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                const SizedBox(width: 20),
                CustomIconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ProductNewModal(producto: null);
                      },
                    );
                  },
                  text: 'ADD PRODUCT',
                  icon: Icons.add_outlined,
                ),
              ],
            )
          ],
        ));
  }
}
