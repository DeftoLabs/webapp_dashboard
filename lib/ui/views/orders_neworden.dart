import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/providers.dart';

class OrdersNewOrdern extends StatelessWidget {
  const OrdersNewOrdern({super.key});

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
                          context, '/dashboard/orders');
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
  String? selectedCliente;
  String? seletedOrdenesType;
  String? selectProduct;
  double? selectPrice;
  double? selectedCantidad = 1;
  DateTime? fechaEntrega = DateTime.now().add(const Duration(days: 1));

  List<Map<String, dynamic>> productsList =
      []; // Lista para almacenar los productos seleccionados

  void addProductRow() {
    setState(() {
      productsList.add({
        'selectProduct': null,
        'selectPrice': null,
        'selectedCantidad': 1,
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    double dynamicHeight = productsList.length * 100.0;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: MediaQuery.of(context).size.width,
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
            Form(
                // key:
                child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          Text('DELIVERY DATE:',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: fechaEntrega ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: Colors.black,
                                      hintColor: Colors.black,
                                      colorScheme: const ColorScheme.light(
                                          primary: Colors.black),
                                      buttonTheme: const ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  fechaEntrega =
                                      pickedDate; // Actualiza el estado con la fecha seleccionada
                                  print(pickedDate);
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 10),
                          fechaEntrega != null
                              ? Text(
                                  DateFormat('dd/MM/yy').format(fechaEntrega!))
                              : const SizedBox.shrink(),
                          const SizedBox(width: 10),
                          Consumer<RutaProvider>(
                            builder: (context, rutaProvider, child) {
                              return SizedBox(
                                width: 150,
                                child: DropdownButtonFormField<String>(
                                  value: seletedOrdenesType,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    label: Center(
                                      child: Text('ORDER TYPE',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black, fontSize: 12),
                                  dropdownColor: Colors.white,
                                  items:
                                      ['INVOICE', 'NOTE', 'OTHER'].map((tipo) {
                                    return DropdownMenuItem<String>(
                                      value: tipo,
                                      child: Text(
                                        tipo,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      seletedOrdenesType = value;
                                      print(seletedOrdenesType);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'PLEASE SELECT A ORDER TYPE';
                                    }
                                    return null;
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                Consumer<RutaProvider>(
                                  builder: (context, rutaProvider, child) {
                                    if (rutaProvider.rutas.isEmpty ||
                                        !rutaProvider.rutas.any((ruta) =>
                                            ruta.usuarioZona.uid ==
                                            selectedUsuarioZona)) {
                                      selectedUsuarioZona = null;
                                    }

                                    return SizedBox(
                                      width: 250,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedUsuarioZona,
                                        decoration: InputDecoration(
                                          hintText: '',
                                          hintStyle:
                                              GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                          label: Center(
                                            child: Text('REPRESENTATIVE',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black),
                                        dropdownColor: Colors.white,
                                        items: rutaProvider.rutas.map((ruta) {
                                          return DropdownMenuItem<String>(
                                            value: ruta.usuarioZona.uid,
                                            child: Text(
                                              ruta.usuarioZona.nombre,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedUsuarioZona = value;
                                          });

                                          // Actualiza la lista de clientes en el RutaProvider
                                          if (value != null) {
                                            rutaProvider
                                                .actualizarClientesRuta(value);
                                            // Reinicia el cliente seleccionado al cambiar de usuarioZona
                                            selectedCliente = null;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'PLEASE SELECT A USER';
                                          }
                                          return null;
                                        },
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(width: 20),

                                // Dropdown para seleccionar cliente
                                Consumer<RutaProvider>(
                                  builder: (context, rutaProvider, child) {
                                    // Si no hay clientes, mostramos un mensaje o un dropdown vacío
                                    if (rutaProvider
                                        .clientesRutaSeleccionada.isEmpty) {
                                      return const Text('');
                                    }

                                    return SizedBox(
                                      width: 400,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedCliente,
                                        decoration: InputDecoration(
                                          hintText: '',
                                          hintStyle:
                                              GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                          label: Center(
                                            child: Text('CUSTOMER',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black),
                                        dropdownColor: Colors.white,
                                        items: rutaProvider
                                            .clientesRutaSeleccionada
                                            .map((cliente) {
                                          return DropdownMenuItem<String>(
                                            value: cliente
                                                .id, // usa el ID o algún identificador del cliente
                                            child: Text(
                                              cliente.nombre,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCliente = value;
                                            print(selectedCliente);
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'PLEASE SELECT A CLIENT';
                                          }
                                          return null;
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
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
                if (selectedCliente != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                 // height: 200,
                // color: Colors.green,
                  child: Column(
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
                          IconButton(
                              onPressed: () {
                                addProductRow();
                              },
                              icon: const Icon(Icons.add_circle_outline_sharp))
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
                                  children: [
                                    const SizedBox(width: 10),
                                    Consumer<ProductsProvider>(
                                      builder:
                                          (context, productProvider, child) {
                                        return SizedBox(
                                          width: 300,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: productData['selectProduct'],
                                            decoration: InputDecoration(
                                              labelText: 'ITEM',
                                              labelStyle:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                    
                                            ),
                                            items: productProvider.productos
                                                .map((producto) {
                                              return DropdownMenuItem<String>(
                                                value: producto.id,
                                                child: Text(
                                                    producto.descripcion
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                productData['selectProduct'] =
                                                    value;
                                                    print(productData['selectProduct']);
                                                productData['selectPrice'] =
                                                    null;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    if (productData['selectProduct'] != null)
                                      Consumer<ProductsProvider>(
                                        builder:
                                            (context, productProvider, child) {
                                          final productoSeleccionado =
                                              productProvider.productos
                                                  .firstWhere(
                                                      (producto) =>
                                                          producto.id ==
                                                          productData[
                                                              'selectProduct'],
                                                      orElse: () =>
                                                          Producto.empty());

                                          return SizedBox(
                                            width: 150,
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: productData['selectPrice']
                                                  ?.toString(),
                                              decoration: InputDecoration(
                                                labelText: 'PRICE',
                                                labelStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                    
                                              ),
                                              items: [
                                                DropdownMenuItem(
                                                    value: productoSeleccionado
                                                        .precio1
                                                        .toString(),
                                                    child: Text(
                                                        '${productoSeleccionado.precio1}')),
                                                DropdownMenuItem(
                                                    value: productoSeleccionado
                                                        .precio2
                                                        .toString(),
                                                    child: Text(
                                                        '${productoSeleccionado.precio2}')),
                                                DropdownMenuItem(
                                                    value: productoSeleccionado
                                                        .precio3
                                                        .toString(),
                                                    child: Text(
                                                        '${productoSeleccionado.precio3}')),
                                                DropdownMenuItem(
                                                    value: productoSeleccionado
                                                        .precio4
                                                        .toString(),
                                                    child: Text(
                                                        '${productoSeleccionado.precio4}')),
                                                DropdownMenuItem(
                                                    value: productoSeleccionado
                                                        .precio5
                                                        .toString(),
                                                    child: Text(
                                                        '${productoSeleccionado.precio5}')),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  productData['selectPrice'] =
                                                      double.tryParse(value!);
                                                      print(productData['selectPrice']);
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    const SizedBox(width: 20),
                                    if (productData['selectPrice'] != null)
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          initialValue:
                                              productData['selectedCantidad']
                                                  .toString(),
                                                  textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            labelText: 'QUANTITY',
                                            labelStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                 focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              productData['selectedCantidad'] =
                                                  double.tryParse(value) ?? 1;
                                                  print(productData['selectedCantidad']);
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                    if (productData['selectPrice'] != null)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            productsList.removeAt(
                                                index); // Eliminar fila
                                          });
                                        },
                                        icon: const Icon(Icons.delete_outline),
                                      )
                                  ],
                                );
                              }))
                    ],
                  ),
                ),
                //Container(
                //    width: MediaQuery.of(context).size.width,
                //    height: 200,
                //    color: Colors.blueAccent)
              ],
            ))
          ],
        ));
  }
}
