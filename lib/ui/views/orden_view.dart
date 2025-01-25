import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';
import 'package:web_dashboard/ui/modals/ordens_add_product.dart';

class OrdenView extends StatefulWidget {
  final String id;

  const OrdenView({super.key, required this.id});

  @override
  State<OrdenView> createState() => _OrdenViewState();
}

class _OrdenViewState extends State<OrdenView> {
  Ordenes? orden;
  OrdenesProvider? ordenesProvider;
  OrdenFormProvider? ordenFormProvider;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      ordenesProvider = Provider.of<OrdenesProvider>(context, listen: false);
      ordenFormProvider = Provider.of<OrdenFormProvider>(context, listen: false);

      ordenesProvider!.getOrdenById(widget.id).then((ordenDB) {
        if (ordenDB != null) {
          ordenFormProvider!.orden = ordenDB;
          ordenFormProvider!.formKey = GlobalKey<FormState>();
          setState(() {
            orden = ordenDB;
          });
        } else {
          NavigationService.replaceTo('/dashboard/orders/records');
        }
      });

      isInitialized = true;
    }
  }

 @override
  void dispose() {
    orden = null;
    ordenFormProvider!.orden = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<AuthProvider>(context).user;
    final todayDay = DateFormat('dd/MM/yy').format(DateTime.now());

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                if(currentUser?.rol == 'MASTER_ROLE'|| currentUser?.rol == 'ADMIN_ROLE')
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            color: Colors.black,
                            onPressed: () {
                              NavigationService.navigateTo('/dashboard/orders/records');
                            },
                            icon: const Icon(Icons.arrow_back_rounded)),
                            const SizedBox(width: 5),
                            Text('TO ORDERS RECORDS', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                      Row(
                      children: [
                        IconButton(
                            color: Colors.black,
                            onPressed: () {
                              NavigationService.navigateTo('/dashboard/orders');
                            },
                            icon: const Icon(Icons.arrow_back_rounded)),
                            const SizedBox(width: 5),
                            Text('TO ORDERS $todayDay', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                )
                else if(currentUser?.rol == 'USER_ROLE')
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.navigateTo('/dashboard/orderbyrepresentative');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Orden View',
                    style: GoogleFonts.plusJakartaSans(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
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
                          final response = await CafeApi.getJson('/ordercustomer/${orden!.id}');

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
                              ..download = 'order_${orden!.id}.pdf';
                            anchor.click();

                            html.Url.revokeObjectUrl(url);
                             NotificationService.showSnackBa('Download Order');
                          } else if (Platform.isAndroid || Platform.isIOS) {
                            // MÓVILES: Guarda y abre el archivo PDF
                            final directory = await getApplicationDocumentsDirectory();
                            final filePath = '${directory.path}/order_${orden!.id}.pdf';
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
                  const SizedBox(width: 10)
              ],
            ),
            const SizedBox(height: 20),
            if (orden == null)
              WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                    color: Color.fromRGBO(255, 0, 200, 0.612),
                    strokeWidth: 4.0),
              )),
            if (orden != null) _OrdenViewBody(orden: orden!)
          ],
        ));
  }
}

class _OrdenViewBody extends StatefulWidget {
  final Ordenes orden;

  const _OrdenViewBody({required this.orden});
  

  @override
  State<_OrdenViewBody> createState() => _OrdenViewBodyState();
}

class _OrdenViewBodyState extends State<_OrdenViewBody> {

    double? selectedPrice;
    DateTime? fechaEntrega;
    double? manualPrice;

    Map<String, bool> manualInputStates = {};
    Map<String, double> selectedPrices = {};
    final Map<String, TextEditingController> textControllers = {};
    
    @override
  void initState() {
    super.initState();
    selectedPrice = null;
    fechaEntrega = widget.orden.fechaentrega; 
  }

  @override
  void dispose() {
  textControllers.forEach((key, controller) => controller.dispose());
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty
        ? profileProvider.profiles[0]
        : null;

    if (profile == null) {
      return const Center(child: Text(''));
    }

    final ordenFormProvider = Provider.of<OrdenFormProvider>(context);
    final orden = ordenFormProvider.orden!;

    //final taxFormProvider = Provider.of<TaxOperationFormProvider>(context);
    //final tax = taxFormProvider.taxoperation;

    final financeProvider = Provider.of<FinanceProvider>(context);
    final finance = financeProvider.finances.isNotEmpty ? financeProvider.finances [0] : null;

    final currentUser = Provider.of<AuthProvider>(context).user;

    final image = (profile.img == null)
        ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'load.gif',
            image: profile.img!,
            width: 35,
            height: 35);            

            // Métodos para obtener los colores dinámicamente
        Color getBackgroundColor(String status) {
          switch (status) {
            case 'ORDER':
              return const Color.fromRGBO(0, 200, 83, 1); // Verde
            case 'APPROVED':
              return const Color.fromARGB(255, 52, 149, 251); // Azul claro
            case 'CANCEL':
              return const Color.fromRGBO(255, 152, 0, 1); // Naranja
            case 'INVOICE':
              return Colors.grey[400]!; // Gris para "INVOICE"
            case 'NOTE':
              return Colors.grey[600]!; // Otro tono de gris para "NOTE"
            default:
              return Colors.grey; // Default para cualquier otro status
          }
        }
        
        Color getBorderColor(String status) {
          switch (status) {
            case 'ORDER':
              return const Color.fromRGBO(177, 255, 46, 1); // Verde claro para ORDER
            case 'APPROVED':
              return const Color.fromARGB(255, 88, 164, 246); // Azul borde
            case 'CANCEL':
              return const Color.fromARGB(255, 255, 194, 102); // Naranja claro borde
            case 'INVOICE':
              return Colors.grey[500]!; // Gris más oscuro para "INVOICE"
            case 'NOTE':
              return Colors.grey[700]!; // Gris aún más oscuro para "NOTE"
            default:
              return Colors.black; // Default
          }
        }

    return Container(
      width: 250,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.razons,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(profile.direccion,
                      style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                  const SizedBox(height: 2),
                  Text('Phone: ${profile.telefono}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                  const SizedBox(height: 2),
                  Text('email: ${profile.email1}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                ],
              )),
              Container(
                height: 100,
                width: 200,
                margin: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text('CREATE:',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('dd/MM/yy - HH:mm')
                              .format(orden.fechacreado),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('MODIFY:',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('dd/MM/yy - HH:mm')
                              .format(orden.updatedAt),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Text('# CONTROL',
                            style: GoogleFonts.plusJakartaSans(fontSize: 12)),
                        const SizedBox(height: 5),
                        Text(orden.control,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 80),
              SizedBox(
                width: 100,
                height: 100,
                child: ClipOval(
                  child: image,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('STATUS',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
            Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: getBackgroundColor(orden.status), // Color de fondo dinámico
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: getBorderColor(orden.status), // Color del borde dinámico
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      orden.status,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),        
              const SizedBox(width: 120),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),

              Flexible(
                flex: 2,
                child: Container(
                  height: 240,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text('CUSTOMER INFO',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('CODE:',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13)),
                              const SizedBox(width: 5),
                              Text(orden.clientes.first.codigo,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(orden.clientes.first.nombre,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                         const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text('BRANCH:', 
                                  style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14)),
                                  const SizedBox(width: 5),
                                  Text(orden.clientes.first.sucursal,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text('ADDRESS:',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(
                                  orden.clientes.first.direccion,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: null,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text('PHONE:',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13)),
                              const SizedBox(width: 5),
                              Text(orden.clientes.first.telefono,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text('email:',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13)),
                              const SizedBox(width: 5),
                              Text(orden.clientes.first.correo,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Segundo cuadro responsivo
              Flexible(
                flex: 2,
                child: CreditInfo(orden: orden),
              ),

              const SizedBox(width: 10),
            ],
          ),
          const Divider(indent: 30, endIndent: 30, color: Colors.black),
          Form(
            key: ordenFormProvider.formKey,
            child: Container(
              width: MediaQuery.of(context).size.width *0.9,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 9,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
              Row(
              children: [
                const SizedBox(width: 20),
                Text('DELIVERY DATE:',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                const SizedBox(width: 5),
                Text(
                  fechaEntrega != null
                      ? DateFormat('dd/MM/yy').format(fechaEntrega!) // Formato de la fecha
                      : 'SELECT DATE', // Cambiar a 'SELECT DATE'
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if( currentUser?.rol != 'USER_ROLE')
                orden.status != 'INVOICE' && orden.status != 'NOTE' && orden.status != 'OTHER' ? 
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime now = DateTime.now();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: fechaEntrega != null && fechaEntrega!.isAfter(now)
                    ? fechaEntrega!
                    : now,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors.black,
                            hintColor: Colors.black,
                            colorScheme: const ColorScheme.light(primary: Colors.black),
                            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      setState(() {
                        fechaEntrega = pickedDate; 
                      });
                    }
                  },
                ) : const Text(''),
                const SizedBox(width: 40),
                if( orden.productos.length <= 16 && currentUser?.rol != 'USER_ROLE')
                orden.status != 'INVOICE' && 
                orden.status != 'NOTE' && 
                orden.status != 'OTHER' ? 
                Text('ADD PRODUCT',
                  style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)) 
                  : const Text(''),
                   if( orden.productos.length <= 16 && currentUser?.rol != 'USER_ROLE')
                   orden.status != 'INVOICE' && 
                   orden.status != 'NOTE' && 
                   orden.status != 'OTHER' ? 
                IconButton(
                  onPressed: (){
                      showDialog(
                      context: context, 
                      builder: ( _ ) => OrdensAddProduct(orderID: widget.orden.id));
                  }, 
                  
                  icon: const Icon(  Icons.add_circle_outline_sharp)
                  ) : const Text(''),
              ],
            ),
              const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('CODE',        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                          DataColumn(label: Text('DESCRIPTION', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                          DataColumn(label: Text('QTY / EDIT',  style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                          DataColumn(label: Text('UNID',        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                          DataColumn(label: Text('PRICE / EDIT',style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                          DataColumn(label: Text('DELETE',            style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        ],
                        rows: orden.productos.map((producto) {
                          return DataRow(cells: [
                            DataCell(Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(producto.nombre),
                            )),
                            DataCell(Text(producto.descripcion.toString())),
                            DataCell(
                              orden.status != 'ORDER' && orden.status != 'APPROVED'
                                  ? Text(
                                      producto.cantidad.toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : ( currentUser?.rol != 'USER_ROLE')?
                                  SizedBox(
                                      width: 90,
                                      height: 40,
                                      child: TextFormField(
                                        initialValue: producto.cantidad.toString(),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLength: 8,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(255, 194, 190, 190),
                                              width: 2,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This field cannot be empty';
                                          }
                                          if (!RegExp(r'^\d{1,4}(\.\d{0,2})?$').hasMatch(value)) {
                                            return 'Max 4 digits and 2 decimals';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          double? cantidad = double.tryParse(value);
                                          if (cantidad != null) {
                                            ordenFormProvider.copyOrdenesWith(
                                              productId: producto.id, // Pasa el ID del producto que se está actualizando
                                              cantidad: cantidad,
                                            );
                                          }
                                        },
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d{1,4}(\.\d{0,2})?$'), // Permite solo números con hasta 4 enteros y 2 decimales
                                          ),
                                        ],
                                      ),
                                    ) : Text(
                                        producto.cantidad.toString(),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            DataCell(Text(producto.unid)),
                            DataCell(
                              orden.status != 'ORDER' && orden.status != 'APPROVED' ? 
                              Text(producto.precio.toString(),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              )
                              ) :
                             ( currentUser?.rol != 'USER_ROLE') ?
                              Row(
                                children: [
                                  Flexible(
                                    child: StatefulBuilder(
                                      builder: (context, setState) {
                                        // Inicializamos las variables si no están definidas previamente
                                        double? currentPrice = selectedPrices[producto.id] ?? producto.precio;
                                  
                                        // Verificamos si el precio es manual
                                        bool isManualInput = manualInputStates[producto.id] ?? false;
                                        bool isPriceManual = ![
                                          producto.precio1,
                                          producto.precio2,
                                          producto.precio3,
                                          producto.precio4,
                                          producto.precio5,
                                        ].contains(currentPrice);
                                  
                                        // Inicializamos el controlador de texto si no existe
                                        if (!textControllers.containsKey(producto.id)) {
                                          textControllers[producto.id] = TextEditingController(text: currentPrice.toString());
                                        }
                                        // Obtenemos el controlador de texto
                                        TextEditingController textController = textControllers[producto.id]!;
                                        return Row(
                                          children: [
                                            // Si el precio es manual, mostramos el TextField
                                            if (isManualInput || isPriceManual)
                                              Expanded(
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: textController,
                                                   inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'^\d{0,5}(\.\d{0,2})?$')),
                                                  ],
                                                  onChanged: (value) {
                                                    double? newPrice = double.tryParse(value);
                                                    if (newPrice != null) {
                                                      setState(() {
                                                        selectedPrices[producto.id] = newPrice;
                                                        ordenFormProvider.copyOrdenesWith(
                                                          productId: producto.id,
                                                          precio: newPrice,
                                                        );
                                                      });
                                                    }
                                                  },
                                                  onFieldSubmitted: (_) {
                                                    setState(() {
                                                      manualInputStates[producto.id] = false; // Finaliza la edición manual
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Enter a Price';
                                                    }
                                                    if (double.tryParse(value) == null) {
                                                      return 'Enter a Number';
                                                    }
                                                    return null; // No error
                                                  },
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 14, 
                                                    fontWeight: FontWeight.bold, 
                                                    color: Colors.black),
                                                  decoration: InputDecoration(
                                                    hintText: 'ENTER PRICE',
                                                    hintStyle: GoogleFonts.plusJakartaSans(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                       borderSide: const BorderSide(
                                                        color: Colors.grey, width: 1),
                                                    ),
                                                     contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                  ),
                                                ),
                                              ),
                                            // Siempre mostramos el DropdownButton para elegir un precio de la base de datos
                                            if (isManualInput || isPriceManual) const SizedBox(width: 8),
                                            Expanded(
                                              child: DropdownButton<double>(
                                                value: isPriceManual ? null : currentPrice,
                                                onChanged: (double? newValue) {
                                                  if (newValue != null) {
                                                    setState(() {
                                                      if (newValue == -1) {
                                                        manualInputStates[producto.id] = true; // Cambia a modo manual
                                                      } else {
                                                        selectedPrices[producto.id] = newValue;
                                                        ordenFormProvider.copyOrdenesWith(
                                                          productId: producto.id,
                                                          precio: newValue,
                                                        );
                                                      }
                                                    });
                                                  }
                                                },
                                                items: [
                                                  ...[
                                                    producto.precio1,
                                                    producto.precio2,
                                                    producto.precio3,
                                                    producto.precio4,
                                                    producto.precio5,
                                                  ].map<DropdownMenuItem<double>>((double value) {
                                                    return DropdownMenuItem<double>(
                                                      value: value,
                                                      child: Text(
                                                        value.toString(),
                                                        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  DropdownMenuItem<double>(
                                                    value: -1, // Valor para activar el precio manual
                                                    child: Text(
                                                      'ENTER PRICE',
                                                      style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ) 
                              : Text(producto.precio.toString(),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              )
                              )
                              ,
                            ),
                          DataCell(
                            orden.status != 'ORDER' && orden.status != 'APPROVED' ? 
                            const Text('')
                            :( currentUser?.rol != 'USER_ROLE') ?
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                if (orden.productos.length == 1) {
                                  // Mostrar alerta si solo queda un producto
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                                        title: Center(
                                          child: 
                                          Text('Warning', 
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold
                                          ))),
                                          content: RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 18,
                                                color: Colors.black, // Color del texto general
                                              ),
                                              children: const <TextSpan>[
                                                TextSpan(text: 'This order has only 1 item. To cancel the order, please use: '),
                                                TextSpan(
                                                  text: '"DELETE"',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold, // Negrita para "CANCEL"
                                                  ),
                                                ),
                                                TextSpan(text: ' button.'),
                                              ],
                                            ),      
                                          ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Cerrar el diálogo
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.black
                                            ),
                                            child: Text('OK',
                                            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white))
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  // Lógica para eliminar el producto si hay más de 1
                                  String productId = producto.id;
                                  String orderId = orden.id;
                                  final saved = await ordenFormProvider.deleteProductByOrder(orderId, productId);
                                  if(saved) {
                                  NotificationService.showSnackBa('Product Deleted');
                                  if (!context.mounted) return;
                                  Provider.of<OrdenesProvider>(context, listen: false).getOrdenById(orderId);
                                  NavigationService.replaceTo('/dashboard/orders/$orderId');
                                } else {
                                  NotificationService.showSnackBarError('Error to Update Order');
                                }
                                }
                              },
                            ) : const Text('')
                            ,
                          ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                 const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: Align(
              alignment: Alignment.centerRight,
              child:Row(
                  mainAxisSize:
                      MainAxisSize.min, // Distribuir el espacio entre las columnas
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Alineación a la derecha
                      children: [
                        Text('SUB TOTAL: ',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                        Text('TAX: ',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                        Text('TOTAL: ',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Alineación a la derecha
                      children: [
                        Text(finance?.mainCurrencysymbol ?? 'NOT',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                        Text('16',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                      Text(finance?.mainCurrencysymbol ?? 'NOT',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Alineación a la izquierda
                      children: [
                        Text(NumberFormat('#,##0.00').format(orden.subtotal)),
                        Text(NumberFormat('#,##0.00').format(orden.tax)),
                        Text(NumberFormat('#,##0.00').format(orden.total)),
                      ],
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ]),
                child: Column(
                  children: [
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text('OBSERVATIONS AND COMMENTS', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('OBSERVATIONS AND COMMENTS BY ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14)
                        ),
                        Text(orden.ruta.first.usuarioZona.nombre, style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Text(orden.comentario.toString())),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('OBSERVATIONS AND COMMENTS:',
                    style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, 
                    fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: 
                    orden.status != 'ORDER' && orden.status != 'APPROVED' ? 
                    Text(orden.comentarioRevision.toString()) 
                    : ( currentUser?.rol != 'USER_ROLE') ?
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: TextFormField(
                         initialValue: orden.comentarioRevision,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 14),
                          decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8.0),),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color:Color.fromARGB(255, 194, 190, 190), width: 2),// Color del borde enfocado
                          borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold // Ajusta el tamaño del texto del error
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                            onChanged: (value) {
                              ordenFormProvider.copyOrdenesWith(
                                comentarioRevision: value.toUpperCase(),
                              );
                            },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be empty.';
                            } else if (value.length > 25) {
                              return 'Cannot exceed 25 characters.';
                            }
                            return null; // Validation successful
                          },
                            )
                    )
                    : Text(orden.comentarioRevision.toString()) 
                    ,
                  )
                  ],)
                ),
                const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 if (orden.status != 'INVOICE' && orden.status != 'NOTE' && orden.status != 'OTHER' && currentUser?.rol != 'USER_ROLE')
                 Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 152, 0, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 194, 102),
                          width: 2,
                        )),
                    child: TextButton(
                      child: Text(
                        'DELETE',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                     onPressed: () async {
                          final dialog = AlertDialog(
                            backgroundColor: const Color.fromRGBO(177, 255, 46, 100).withOpacity(0.9),
                            title: Center(
                              child: Text('Are you sure to delete this Order?', 
                               style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                                ))),
                            content: Text(orden.clientes.first.nombre,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                            )),
                            actions: [
                              TextButton(
                                child: Text('No',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                )
                                ),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                }, 
                              ),
                              TextButton(
                                child: Text('Yes, Delete',  
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                )),
                                onPressed: () async {
                                  final ordenesProvider = Provider.of<OrdenesProvider>(context, listen: false);
                                  await ordenesProvider.deleteOrden(orden.id);
                                  if (context.mounted) {
                                    NotificationService.showSnackBa('Order has been Deleted');
                                    NavigationService.replaceTo('/dashboard/orders');
                                  }
                                  }, 
                              )
                                ],
                            );

               showDialog(
                  context: context, 
                  builder: ( _ ) => dialog);
                         } 
                    ),
                  ),
                  const SizedBox(width: 20),
                     if (orden.status != 'INVOICE' && orden.status != 'NOTE' && orden.status != 'OTHER' && currentUser?.rol != 'USER_ROLE')
                Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 200, 83, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(177, 255, 46, 100),
                          width: 2,
                        )),
                    child: TextButton(
                      child: Text(
                        'SAVE',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                  onPressed: () async {
                      if (ordenFormProvider.formKey.currentState!.validate()) {
                        final saved = await ordenFormProvider.updateOrder(fechaEntrega);
                        if(saved) {
                          NotificationService.showSnackBa('Order Updated');
                          if (!context.mounted) return;
                          Provider.of<OrdenesProvider>(context, listen: false).getPaginatedOrdenes;
                          NavigationService.navigateTo('/dashboard/orders/records');
                        } else {
                          NotificationService.showSnackBarError('Error to Update Order');
                        }
                      } else {
                        NotificationService.showSnackBarError('Invalid Data');
                      }
                    }
                  ),
                  ),
                   const SizedBox(width: 20),

              ],
            ),
               
          const SizedBox(height: 40),
              ],
            ),
          );
        }
      }

class CreditInfo extends StatelessWidget {
  const CreditInfo({
    super.key,
    required this.orden,
  });

  final Ordenes orden;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('CREDIT:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(orden.clientes.first.credito.toString(),
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                  Text('DAYS',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(orden.ruta.first.usuarioZona.nombre,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 15),
                  Text('COD:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                  const SizedBox(width: 5),
                  Text(orden.ruta.first.usuarioZona.zone,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text('ROUTE:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                  const SizedBox(width: 5),
                  Text(orden.ruta.first.nombreRuta,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text('DELIVERY:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      orden.clientes.first.direccion,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: null,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('TYPE:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(orden.tipo,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }
}
