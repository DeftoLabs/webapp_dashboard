import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class OrdersNewSalesRepresentative extends StatelessWidget {
  const OrdersNewSalesRepresentative({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty
        ? profileProvider.profiles[0]
        : null;

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
                      Navigator.pushReplacementNamed(
                          context, '/dashboard/orderbyrepresentative');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'CREATE A ORDER',
                    style: GoogleFonts.plusJakartaSans(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: image,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const OrdenBody()
          ],
        ));
  }
}

class OrdenBody extends StatefulWidget {
  const OrdenBody({super.key});

  @override
  State<OrdenBody> createState() => _OrdenBodyState();
}

class _OrdenBodyState extends State<OrdenBody> {
  String? selectedUsuarioZona;
  String? cliente;
  String? ruta;
  String? tipo;
  String? producto;
  double? precio;
  double? cantidad = 1;
  String? unid;
  String? comentario = '';
  DateTime? fechaentrega = DateTime.now().add(const Duration(days: 1));
    final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> productsList = []; // Lista para almacenar los productos seleccionados


  bool isFirstProductAdded = false;

  void addProductRow() {
    if (productsList.isEmpty) {
      productsList.add({
        'producto': null,
        'precio': null,
        'cantidad': 1,
        'unid':null,
        'isFirstRow': true
      });
    } else {
      productsList.add({
        'producto': null,
        'precio': null,
        'cantidad': 1,
        'unid':null,
        'isFirstRow': false
      });
    }
    isFirstProductAdded = true;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    double dynamicHeight = productsList.length * 50.0;
    double screenWidth = MediaQuery.of(context).size.width;

    final ordenNewFormProvider = Provider.of<OrdenNewFormProvider>(context);

     final currentUser = Provider.of<AuthProvider>(context).user;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.8,
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
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
                Form(
                  key: formKey, 
                    child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width < 530
                          ? 400
                          : MediaQuery.of(context).size.width < 1170
                              ? 400
                              : 200,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Usa Row si el ancho es mayor a 530, de lo contrario usa Column
                              return constraints.maxWidth > 530
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 20),
                                        Text('DELIVERY DATE:',
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 5),
                                        IconButton(
                                          icon:
                                              const Icon(Icons.calendar_today),
                                          onPressed: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: fechaentrega ??
                                              DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101),
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor: Colors.black,
                                                    hintColor: Colors.black,
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                            primary:
                                                                Colors.black),
                                                    buttonTheme:
                                                        const ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (pickedDate != null) {
                                              setState(() {
                                                fechaentrega = pickedDate;
                                              });
                                            }
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        fechaentrega != null
                                            ? Text(DateFormat('dd/MM/yy')
                                                .format(fechaentrega!))
                                            : const SizedBox.shrink(),
                                        const SizedBox(width: 10),
                                        Consumer<RutaProvider>(
                                          builder:
                                              (context, rutaProvider, child) {
                                            return SizedBox(
                                              width: 150,
                                              child: DropdownButtonFormField<String>(
                                                value: tipo,
                                                decoration: InputDecoration(
                                                  hintText: '',
                                                  hintStyle: GoogleFonts.plusJakartaSans(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                  label: Center(
                                                    child: Text('ORDER TYPE',
                                                        style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 12,color: Colors.black,fontWeight:FontWeight.bold)),
                                                  ),
                                                  focusedBorder:const OutlineInputBorder(borderSide: BorderSide(color:Colors.white,  width: 2.0,),
                                                  ),
                                                  enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color:Colors.white,  width: 2.0,),
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                ),
                                                style:GoogleFonts.plusJakartaSans(
                                                color: Colors.black,fontSize: 12),
                                                dropdownColor: Colors.white,
                                                items: [
                                                  'INVOICE','NOTE','OTHER'
                                                ].map((tipo) {
                                                  return DropdownMenuItem<String>(
                                                    value: tipo,
                                                    child: Text(tipo,style: const TextStyle(
                                                    color: Colors.black),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    tipo = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'SELECT A ORDER TYPE';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox( height: 20), // Ajusta el espaciado en caso de cambiar a Column
                                        Text('DELIVERY DATE:',
                                            style: GoogleFonts.plusJakartaSans(fontSize: 12,fontWeight: FontWeight.bold)),
                                        const SizedBox(height:10), // Espaciado vertical entre elementos en Column
                                        IconButton(
                                          icon: const Icon(Icons.calendar_today),
                                          onPressed: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: fechaentrega ?? DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101),
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Theme(
                                                  data: ThemeData.light().copyWith( primaryColor:Colors.black, hintColor: Colors.black, colorScheme:
                                                  const ColorScheme.light(primary: Colors.black),
                                                  buttonTheme:const ButtonThemeData(
                                                  textTheme:ButtonTextTheme.primary),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (pickedDate != null) {
                                              setState(() {fechaentrega = pickedDate; });
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 15),
                                        fechaentrega != null ? Text(DateFormat('dd/MM/yy') .format(fechaentrega!)): const SizedBox.shrink(),
                                        const SizedBox(height: 10),
                                        Consumer<RutaProvider>(
                                          builder:
                                              (context, rutaProvider, child) {
                                            return SizedBox(
                                              width: 150,
                                              child: DropdownButtonFormField<String>(
                                                value: tipo,
                                                decoration: InputDecoration(
                                                  hintText: '',
                                                  hintStyle: GoogleFonts.plusJakartaSans(fontSize: 12,color: Colors.black),
                                                  label: Center(
                                                    child: Text('ORDER TYPE',
                                                    style: GoogleFonts.plusJakartaSans(fontSize: 12,color: Colors.black,fontWeight:FontWeight.bold)),
                                                  ),
                                                  focusedBorder:const OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
                                                  enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
                                                ),
                                                icon: const Icon(Icons.arrow_drop_down,color: Colors.black),
                                                style:GoogleFonts.plusJakartaSans(color: Colors.black,fontSize: 12), dropdownColor: Colors.white,
                                                items: ['INVOICE','NOTE','OTHER'
                                                ].map((tipo) {
                                                  return DropdownMenuItem<String>(
                                                    value: tipo,
                                                    child: Text(tipo,style: const TextStyle(color: Colors.black)));
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    tipo = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'PLEASE SELECT A ORDER TYPE';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                            },
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            indent: 30,
                            endIndent: 30,
                            color: Colors.black54,
                          ),
                          const SizedBox(height: 10),
Center(
  child: LayoutBuilder(
    builder: (context, constraints) {
      bool isSmallScreen = constraints.maxWidth < 910;
      return SingleChildScrollView(
        child: Column(
          children: [
            Text(
              currentUser!.uid,
              style: const TextStyle(color: Colors.white),
            ),
            isSmallScreen
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Mostrar el nombre del Sales Representative como texto
                      SizedBox(
                        width: 250,
                        child: Consumer<RutaProvider>(
                          builder: (context, rutaProvider, child) {
                            // Validación para evitar errores
                            if (rutaProvider.rutas.any((ruta) => ruta.usuarioZona.uid == currentUser.uid)) {
                              if (selectedUsuarioZona == null) {
                                selectedUsuarioZona = currentUser.uid;
                                ruta = rutaProvider.rutas
                                    .firstWhere((ruta) => ruta.usuarioZona.uid == currentUser.uid)
                                    .id;
                                rutaProvider.actualizarClientesRuta(selectedUsuarioZona!);
                              }

                              final representante = rutaProvider.rutas
                                  .firstWhere((ruta) => ruta.usuarioZona.uid == currentUser.uid)
                                  .usuarioZona;

                              return Text(
                                representante.nombre,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Text(
                                  'NO ROUTE or ',
                                  style: GoogleFonts.plusJakartaSans( fontSize: 14, color: Colors.black)),
                                    Text(
                                  'CUSTOMERS ASSIGNED',
                                  style: GoogleFonts.plusJakartaSans( fontSize: 14, color: Colors.black))
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Customers Dropdown
                      SizedBox(
                        width: 450,
                        child: Consumer<RutaProvider>(
                          builder: (context, rutaProvider, child) {
                            if (rutaProvider.clientesRutaSeleccionada.isEmpty) {
                              return const Text('');
                            }

                            return DropdownButtonFormField<String>(
                              value: cliente,
                              decoration: InputDecoration(
                                label: Center(
                                  child: Text(
                                    'CUSTOMER',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                              style: GoogleFonts.plusJakartaSans(color: Colors.black),
                              dropdownColor: Colors.white,
                              items: rutaProvider.clientesRutaSeleccionada.map((cliente) {
                                return DropdownMenuItem<String>(
                                  value: cliente.id,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        cliente.nombre,
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        cliente.sucursal,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  cliente = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'PLEASE SELECT A CUSTOMER';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      // Representante (Sales Representative)
                      SizedBox(
                        width: 250,
                        child: Consumer<RutaProvider>(
                          builder: (context, rutaProvider, child) {
                            if (rutaProvider.rutas.any((ruta) => ruta.usuarioZona.uid == currentUser.uid)) {
                              if (selectedUsuarioZona == null) {
                                selectedUsuarioZona = currentUser.uid;
                                ruta = rutaProvider.rutas
                                    .firstWhere((ruta) => ruta.usuarioZona.uid == currentUser.uid)
                                    .id;
                                rutaProvider.actualizarClientesRuta(selectedUsuarioZona!);
                              }
                
                              final representante = rutaProvider.rutas
                                  .firstWhere((ruta) => ruta.usuarioZona.uid == currentUser.uid)
                                  .usuarioZona;
                
                              return Text(
                                representante.nombre,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Text(
                                  'NO ROUTE or ',
                                  style: GoogleFonts.plusJakartaSans( fontSize: 14, color: Colors.black)),
                                    Text(
                                  'CUSTOMERS ASSIGNED',
                                  style: GoogleFonts.plusJakartaSans( fontSize: 14, color: Colors.black))
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Dropdown de clientes (Customers)
                      SizedBox(
                        width: 450,
                        child: Consumer<RutaProvider>(
                          builder: (context, rutaProvider, child) {
                            if (rutaProvider.clientesRutaSeleccionada.isEmpty) {
                              return const Text('');
                            }
                
                            return DropdownButtonFormField<String>(
                              value: cliente,
                              decoration: InputDecoration(
                                label: Center(
                                  child: Text(
                                    'CUSTOMER',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                              style: GoogleFonts.plusJakartaSans(color: Colors.black),
                              dropdownColor: Colors.white,
                              items: rutaProvider.clientesRutaSeleccionada.map((cliente) {
                                return DropdownMenuItem<String>(
                                  value: cliente.id,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        cliente.nombre,
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        cliente.sucursal,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  cliente = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'PLEASE SELECT A CUSTOMER';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
    },
  ),
)

                        ],
                      ),
                    ),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Colors.black26,
                    ),
                    if (cliente != null)
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text('ADD PRODUCT',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 20),
                                if (!isFirstProductAdded || productsList.isEmpty)
                                  IconButton(
                                      onPressed: () {
                                        addProductRow();
                                      },
                                      icon: const Icon(
                                          Icons.add_circle_outline_sharp))
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: dynamicHeight,
                              child: ListView.builder(
                                  itemCount: productsList.length,
                                  itemBuilder: (context, index) {
                                    final productData = productsList[index];
                                    return Row(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 10),
                                        Consumer<ProductsProvider>(
                                          builder: (context, productProvider,
                                              child) {
                                            return SizedBox(
                                              width: 275,
                                              child: DropdownButtonFormField<String>(
                                                value: productData['producto'],
                                                decoration: InputDecoration(
                                                  labelText: 'ITEM',
                                                  labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius:BorderRadius.circular(15),
                                                    borderSide:const BorderSide(color: Colors.white,width: 1)),
                                                  enabledBorder:OutlineInputBorder(borderRadius:
                                                  BorderRadius.circular(15),
                                                  borderSide:const BorderSide(color: Colors.white,width:1)),
                                                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                                                  errorStyle: const TextStyle(
                                                  color: Colors.red, // Asegura que el mensaje sea visible
                                                  fontSize: 12,
                                                ),
                                                ),
                                                items: productProvider.productos
                                                    .map((producto) {
                                                  return DropdownMenuItem<String>(
                                                    value: producto.id,
                                                    child: Text(
                                                        producto.descripcion.toString(),
                                                        style: const TextStyle(color:Colors.black)),
                                                  );
                                                }).toList(),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'SELECT A ITEM';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                  productData['producto'] = value;
                                                  final productoSeleccionado = productProvider.productos.firstWhere(
                                                  (producto) => producto.id == value,
                                                  orElse: () => Producto.empty(),
                                                );
                                                  productData['precio'] = null;
                                                  productData['unid'] = productoSeleccionado.unid;
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 20),
                                         SizedBox(child: Text(productData['unid'] ?? '',
                                         style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)
                                         )),
                                        const SizedBox(width: 20),
                                        if (productData['producto'] != null)
                                          Consumer<ProductsProvider>(
                                            builder: (context, productProvider,
                                                child) {
                                              final productoSeleccionado =
                                                  productProvider.productos
                                                      .firstWhere(
                                                          (producto) =>
                                                              producto.id == productData[ 'producto'],
                                                          orElse: () =>
                                                              Producto.empty());
                                              return SizedBox(
                                                width: 95,
                                                child: DropdownButtonFormField<String>(
                                                  value:productData['precio']?.toString(),
                                                  decoration: InputDecoration(
                                                    labelText: 'PRICE',
                                                    labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12,color: Colors.black,fontWeight:FontWeight.bold,),
                                                    focusedBorder:OutlineInputBorder(
                                                      borderRadius:BorderRadius.circular(15),
                                                      borderSide:const BorderSide(color:Colors.white,width: 1),),
                                                    enabledBorder:OutlineInputBorder(
                                                      borderRadius:BorderRadius.circular(15),
                                                      borderSide:
                                                          const BorderSide(color:Colors.white,width: 1),),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                  BorderRadius.circular(15),),),
                                                  items: [
                                                    DropdownMenuItem(value:productoSeleccionado.precio1.toString(),child: Text('${productoSeleccionado.precio1}')),
                                                    DropdownMenuItem(value:productoSeleccionado.precio2.toString(),child: Text('${productoSeleccionado.precio2}')),
                                                    DropdownMenuItem(value:productoSeleccionado.precio3.toString(),child: Text('${productoSeleccionado.precio3}')),
                                                    DropdownMenuItem(value:productoSeleccionado.precio4.toString(),child: Text('${productoSeleccionado.precio4}')),
                                                    DropdownMenuItem(value:productoSeleccionado.precio5.toString(),child: Text('${productoSeleccionado.precio5}')),
                                                  ],
                                                  validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'SELECT A PRICE';
                                                  }
                                                  return null;
                                                },
                                                  onChanged: (value) {
                                                    setState(() {
                                                    productData['precio'] = double.tryParse(value!);
                                                   
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        const SizedBox(width: 20),
                                        if (productData['precio'] != null)
                                          SizedBox(
                                            width: 95,
                                            child: TextFormField(
                                              initialValue: productData['cantidad'].toString(),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                labelText: 'QUANTITY',
                                                labelStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                focusedBorder:OutlineInputBorder(
                                                  borderRadius:BorderRadius.circular(15),
                                                  borderSide: const BorderSide(color: Colors.white,width: 1),),
                                                enabledBorder:OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                  borderSide: const BorderSide(color: Colors.white,width: 1),),
                                                border: OutlineInputBorder(borderRadius:BorderRadius.circular(15), ),
                                              ),
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                   validator: (value) {
                                                  if (value == null || value.isEmpty) return 'NUMBER';
                                                  if (!RegExp(r'^\d{1,4}(\.\d{0,4})?$').hasMatch(value)) return 'MAX 4 DIGITS(.)';
                                                  return null;
                                                },
                                              onChanged: (value) {
                                                setState(() {
                                                  productData['cantidad'] =double.tryParse(value) ??1;
                                                });
                                              },
                                              inputFormatters: [
                                                // Permitir solo números y hasta dos decimales, sin números negativos
                                               FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')), 
                                              ],
                                            ),
                                          ),
                                        const SizedBox(width: 20),
                                        if (productData['precio'] != null)
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                productsList.removeAt(
                                                    index); // Eliminar fila
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.delete_outline),
                                          ),
                                        if (productData['precio'] != null)
                                          IconButton(
                                              onPressed: addProductRow,
                                              icon: const Icon(Icons.add))
                                      ],
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                                              Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('OBSERVATIONS AND COMMENTS:',
                    style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //height: 40,
                      child: TextFormField(
                         initialValue:comentario,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 12),
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
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                            onChanged: (value) {
                             comentario = value.toUpperCase();
                            },
                          validator: (value) {
                            if (value == null) {
                              return '';
                            } else if (value.length > 100) {
                              return 'CANNOT EXCEED 100 CHARACTERS';
                            }
                            return null; // Validation successful
                          },
                            )
                    ),
                  ),
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
                                      onPressed: () {
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
                                              TextSpan(text: 'Are you sure you want to cancel this order?'),
                                            ],
                                          ),      
                                        ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                           NavigationService.replaceTo('/dashboard/orderbyrepresentative'); 
                                          },
                                          child: Text('YES', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                           Navigator.of(context).pop(); // Cerrar el diálogo
                                          },
                                          child: Text('NO', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                      }),
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
                                        color: const Color.fromRGBO(
                                            177, 255, 46, 100),
                                        width: 2,
                                      )),
                                  child: TextButton(
                                      child: Text(
                                        'SAVE',
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: ()async {
                                         if (productsList.isEmpty) {
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
                                              TextSpan(text: 'The product list is empty. Please add at least one product.'),
                                            ],
                                          ),      
                                        ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                           Navigator.of(context).pop(); // Cerrar el diálogo
                                          },
                                          child: Text('OK', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                      } else
                                        if (formKey.currentState!.validate()) {
                                                try {

                                                  List<Map<String, dynamic>> productos = productsList.map((productData) {
                                                      return {
                                                        'producto': productData['producto'],
                                                        'cantidad': productData['cantidad'],
                                                        'precio': productData['precio'],
                                                      };
                                                    }).toList();

                                                 final saved =  await ordenNewFormProvider.createOrden(
                                                   cliente: cliente ?? '',
                                                    ruta: ruta ?? '',
                                                    productos: productos,
                                                    fechaentrega: fechaentrega!,
                                                    tipo: tipo.toString(),
                                                    comentario: comentario,
                                                  );
                                                 if (saved == null) {
                                              if (!context.mounted) return;
                                              NotificationService.showSnackBa('Orden Created');
                                              NavigationService.replaceTo('/dashboard/orderbyrepresentative');
                                          }
                                      } catch (e) {
                                          NotificationService.showSnackBarError('No se pudo guardar la Orden: $e');
                                      }
                                              }
                                       
                                      }
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
