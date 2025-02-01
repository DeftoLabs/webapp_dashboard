import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../providers/ordenes_provider.dart';

class DashboardTop5ProductByMonth extends StatelessWidget {
  const DashboardTop5ProductByMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdenesProvider>(
      builder: (context, ordenesProvider, child) {
        final top5Productos = ordenesProvider.getTop5ProductsOfLast30Days();

        // Verificar si la lista está vacía
        if (top5Productos.isEmpty) {
          return Center(
            child: Text(
              'NO INFO',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16, fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 99, 99, 99)),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título con la fecha de hoy
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10, horizontal: 5),
              child: Center(
                child: Text(
                  'TOP 5 PRODUCT IN THE LAST 30 DAYS', // Título dinámico con fecha
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 99, 99, 99)),
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

                  // Cambiar el fondo de cada línea de manera alterna
                  final backgroundColor = index % 2 == 0
                      ? Colors.grey.shade50 // Fondo claro para índices pares
                      : Colors.grey.shade100; // Fondo más oscuro para índices impares
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor, // Aplicar el color de fondo
                        borderRadius: BorderRadius.circular(8), // Opcional, para bordes redondeados
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26, // Color de la sombra
                            blurRadius: 4, // Difusión de la sombra
                            offset: Offset(0, 2), // Posición de la sombra
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    style: GoogleFonts.plusJakartaSans(fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // QTY SOLD
                                      Text(
                                        'QTY: ${producto.cantidad}',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                      // UNIT
                                      Text(
                                        producto.unid,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
