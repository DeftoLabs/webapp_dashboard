import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class OrdensAddProduct extends StatefulWidget {
  final String orderID;

  const OrdensAddProduct({super.key, required this.orderID});

  @override
  State<OrdensAddProduct> createState() => _OrdensAddProductState();
}

class _OrdensAddProductState extends State<OrdensAddProduct> {
  Map<String, dynamic> productData = {
    'producto': null,
    'precio': null,
    'cantidad': 1,
    'unid': null,
  };

  @override
  Widget build(BuildContext context) {
    final ordenFormProvider = Provider.of<OrdenFormProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 400,
        width: 600,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 60, 65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Product',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white70),
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ProductsProvider>(
                    builder: (context, productProvider, child) {
                      return SizedBox(
                        width: 275,
                        child: DropdownButtonFormField<String>(
                          value: productData['producto'],
                          decoration: InputDecoration(
                            labelText: 'ITEM',
                            labelStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: Colors.white,
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          selectedItemBuilder: (BuildContext context) {
                            return productProvider.productos
                                .map<Widget>((producto) {
                              return Text(
                                producto.descripcion.toString(),
                                style: const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                          items: productProvider.productos.map((producto) {
                            return DropdownMenuItem<String>(
                              value: producto.id,
                              child: Text(
                                producto.descripcion.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
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
                              final productoSeleccionado =
                                  productProvider.productos.firstWhere(
                                (producto) => producto.id == value,
                                orElse: () => Producto.empty(),
                              );
                              productData['unid'] = productoSeleccionado.unid;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    child: Text(
                      productData['unid'] ?? '',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (productData['producto'] != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                     Consumer<ProductsProvider>(
                    builder: (context, productProvider, child) {
                      final productoSeleccionado = productProvider.productos
                          .firstWhere(
                              (producto) =>
                                  producto.id == productData['producto'],
                              orElse: () => Producto.empty());
                      return SizedBox(
                        width: 215,
                        child: DropdownButtonFormField<String>(
                          value: productData['precio']?.toString(),
                          decoration: InputDecoration(
                            labelText: 'PRICE',
                            labelStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: Colors.white,
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          selectedItemBuilder: (BuildContext context) {
                            return [
                              productoSeleccionado.precio1,
                              productoSeleccionado.precio2,
                              productoSeleccionado.precio3,
                              productoSeleccionado.precio4,
                              productoSeleccionado.precio5,
                            ].map<Widget>((precio) {
                              return Text(
                                '$precio',
                                style: const TextStyle(
                                    color: Colors
                                        .white), // Estilo para el valor seleccionado
                              );
                            }).toList();
                          },
                          items: [
                            DropdownMenuItem(
                                value: productoSeleccionado.precio1.toString(),
                                child: Text(
                                  '${productoSeleccionado.precio1}',
                                  style: const TextStyle(color: Colors.black),
                                )),
                            DropdownMenuItem(
                                value: productoSeleccionado.precio2.toString(),
                                child: Text(
                                  '${productoSeleccionado.precio2}',
                                  style: const TextStyle(color: Colors.black),
                                )),
                            DropdownMenuItem(
                                value: productoSeleccionado.precio3.toString(),
                                child: Text(
                                  '${productoSeleccionado.precio3}',
                                  style: const TextStyle(color: Colors.black),
                                )),
                            DropdownMenuItem(
                                value: productoSeleccionado.precio4.toString(),
                                child: Text(
                                  '${productoSeleccionado.precio4}',
                                  style: const TextStyle(color: Colors.black),
                                )),
                            DropdownMenuItem(
                                value: productoSeleccionado.precio5.toString(),
                                child: Text(
                                  '${productoSeleccionado.precio5}',
                                  style: const TextStyle(color: Colors.black),
                                )),
                          ],
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
                  SizedBox(
                    width: 95,
                    child: TextFormField(
                      initialValue: productData['cantidad'].toString(),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: 'QUANTITY',
                        labelStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          productData['cantidad'] = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),
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
                    '+  PRODUCT',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (productData['producto'] == null ||
                        productData['precio'] == null) {
                      NotificationService.showSnackBarError(
                          'Please complete all fields');
                      return;
                    }
                    final orderId = widget.orderID;
                    final saved = await ordenFormProvider.addProductByOrder(
                      orderId,
                      productData,
                    );
                    if (saved) {
                      NotificationService.showSnackBa('Product added!');
                      if (!context.mounted) return;
                      Provider.of<OrdenesProvider>(context, listen: false)
                          .getOrdenById(orderId);
                      NavigationService.replaceTo('/dashboard/orders/$orderId');
                    } else {
                      NotificationService.showSnackBarError(
                          'Failed to add product');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
