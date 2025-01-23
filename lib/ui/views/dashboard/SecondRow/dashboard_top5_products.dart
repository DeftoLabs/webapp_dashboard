import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../providers/ordenes_provider.dart';

class DashboardTop5ProductByDay extends StatelessWidget {
  const DashboardTop5ProductByDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdenesProvider>(
      builder: (context, ordenesProvider, child) {
        final top5Productos = ordenesProvider.getTop5ProductsOfToday();

        // Verificar si la lista está vacía
        if (top5Productos.isEmpty) {
          return Center(
            child: Text(
              'NO PRODUCT SOLD TODAY',
              style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título con la fecha de hoy
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Center(
                child: Text(
                  'TOP 5 SOLD PRODUCT TODAY', // Título dinámico con fecha
                 style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
const SizedBox(height: 5),
            // Lista de productos
            Expanded(
              child: ListView.builder(
                itemCount: top5Productos.length,
                itemBuilder: (context, index) {
                  final producto = top5Productos[index];

                  // Imagen del producto utilizando la misma lógica que en ProductsDTS
                  final image = (producto.img == null || producto.img!.isEmpty) 
                    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35,) 
                    : FadeInImage.assetNetwork(
                        placeholder: 'load.gif', 
                        image: producto.img!, width: 35, height: 35,
                    );

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
                    child: Row(
                      children: [
                        // Imagen del producto
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(child: image),
                        ),

                        const SizedBox(width: 16),

                        // Descripción y detalles del producto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto.descripcion ?? 'NOT DESCRIPTION',
                                style: GoogleFonts.plusJakartaSans(fontSize: 10),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // QTY SOLD
                                  Text('QTY: ${producto.cantidad}', 
                                    style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                  // UNIT
                                  Text(producto.unid,
                                    style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
