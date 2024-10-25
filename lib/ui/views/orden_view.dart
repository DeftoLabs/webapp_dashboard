import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class OrdenView extends StatefulWidget {
  final String id;

  const OrdenView({super.key, required this.id});

  @override
  State<OrdenView> createState() => _OrdenViewState();
}

class _OrdenViewState extends State<OrdenView> {
  Ordenes? orden;

  @override
  void initState() {
    super.initState();
    final ordenesProvider = Provider.of<OrdenesProvider>(context, listen: false);
    final ordenFormProvider = Provider.of<OrdenFormProvider>(context, listen: false);

    ordenesProvider.getOrdenById(widget.id).then((ordenDB) {
      ordenFormProvider.orden = ordenDB;
      setState(() { orden = ordenDB; });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.navigateTo('/dashboard/orders/records');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Orden View',
                    style: GoogleFonts.plusJakartaSans(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                )
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

    double? selectedPrice ;

    @override
  void initState() {
    super.initState();
    selectedPrice = null;
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
                        Text('Create:',
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
                        Text('Modify:',
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
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text('# CONTROL',
                            style: GoogleFonts.plusJakartaSans(fontSize: 16)),
                        const SizedBox(width: 5),
                        Text(orden.control,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16, fontWeight: FontWeight.bold)),
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
                          Row(
                            children: [
                              Text(orden.clientes.first.nombre,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('CODE',        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('DESCRIPTION', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('QTY / EDIT',  style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('UNID',        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('PRICE',       style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('EDIT PRICE',  style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('DELETE',      style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),)),
                      ],
                      rows: orden.productos.map((producto) {
                        return DataRow(cells: [
                          DataCell(Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(producto.nombre),
                          )),
                          DataCell(Text(producto.descripcion.toString())),
                          DataCell(
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: TextFormField(
                                initialValue: producto.cantidad.toString(),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                                maxLength: 8,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                         color: Color.fromARGB(255, 194, 190, 190), width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'This field cannot be empty';
                                  if (!RegExp(r'^\d{1,4}(\.\d{0,4})?$').hasMatch(value)) return 'Max 4 Digits(.)';
                                  return null;
                                },
                                 onChanged: (value) {
                                    double? cantidad = double.tryParse(value);
                                    ordenFormProvider.copyOrdenesWith(cantidad: cantidad);
                                    print(value);
                                  },
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  // Permitir solo números y hasta dos decimales, sin números negativos
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')), 
                                ],
                              ),
                            ),
                          ),
                          DataCell(Text(producto.unid)),
                             DataCell(
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: TextFormField(
                                initialValue: producto.precio!.toString(),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                                maxLength: 8,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 194, 190, 190), width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'This field cannot be empty';
                                  if (!RegExp(r'^\d{1,4}(\.\d{0,4})?$').hasMatch(value)) return 'Max 4 Digits(.)';
                                  return null;
                                },
                                 onChanged: (value) {
                                    double? precio = double.tryParse(value);
                                    ordenFormProvider.copyOrdenesWith(precio: precio);
                                    print(value);
                                  },
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  // Permitir solo números y hasta dos decimales, sin números negativos
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')), 
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              alignment: Alignment.center,
                              child: DropdownButton<double>(
                                value: selectedPrice,
                                hint: Text('SELECT',
                                style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                                )
                                ),
                                onChanged: (double? newValue) {
                                  setState(() {
                                    selectedPrice = newValue!;
                                  });
                                },
                                style: const TextStyle(color: Colors.black),
                                dropdownColor: Colors.white,
                                items: [
                                  DropdownMenuItem(
                                    value: producto.precio1,
                                    child: Text(producto.precio1.toStringAsFixed(2)),
                                  ),
                                  DropdownMenuItem(
                                    value: producto.precio2,
                                    child: Text(producto.precio2.toStringAsFixed(2)),
                                  ),
                                  DropdownMenuItem(
                                    value: producto.precio3,
                                    child: Text(producto.precio3.toStringAsFixed(2)),
                                  ),
                                  DropdownMenuItem(
                                    value: producto.precio4,
                                    child: Text(producto.precio4.toStringAsFixed(2)),
                                  ),
                                  DropdownMenuItem(
                                    value: producto.precio5,
                                    child: Text(producto.precio5.toStringAsFixed(2)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        DataCell(
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
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
                                                text: '"CANCEL"',
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
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Lógica para eliminar el producto si hay más de 1
                                setState(() {
                                
                                });
                              }
                            },
                          ),
                        ),
                        ]);
                      }).toList(),
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
              child: (orden.status == 'ORDER' || orden.status == 'APPROVED' || orden.status == 'CANCEL') 
                    ? const SizedBox.shrink() // No muestra nada si el estatus es ORDER, APPROVED o CANCEL
                    :Row(
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
                        Text('USD',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                        Text('16%',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                        Text('USD',
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
                    child: Text('OBSERVATIONS AND COMMENTS BY ${orden.ruta.first.usuarioZona.nombre} :',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold)
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
                    child: SizedBox(
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
                                ordenFormProvider.copyOrdenesWith( comentarioRevision: value);
                                print(value);
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
                    ),
                  )
                  ],)
                ),
                const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        'CANCEL',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                    
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
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
                        final saved = await ordenFormProvider.updateOrder();
                        if(saved) {
                          NotificationService.showSnackBa('Order Updated');
                        } else {
                          NotificationService.showSnackBarError('Error to Update Order');
                        }
                      } else {
                        NotificationService.showSnackBarError('Invalid Data');
                      }
                    }
                  ),
                  ),
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
              Row(
                children: [
                  Text('DELIVERY DATE:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('dd/MM/yy').format(orden.fechaentrega),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
