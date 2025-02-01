import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../providers/ordenes_provider.dart';

class DashboardTop5CustomerByDayUserRole extends StatelessWidget {
  const DashboardTop5CustomerByDayUserRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdenesProvider>(
      builder: (context, ordenesProvider, child) {
        final top5Customers = ordenesProvider.getTop5CustomersOfTodayByUser(context);

        // Verificar si la lista está vacía
        if (top5Customers.isEmpty) {
          return Center(
            child: Text(
              'NO ORDER TODAY',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título con la fecha de hoy
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Center(
                child: Text(
                  'TOP 5 CUSTOMER TODAY',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Lista de clientes
            Expanded(
              child: ListView.builder(
                itemCount: top5Customers.length,
                itemBuilder: (context, index) {
                  final customer = top5Customers[index];
                  final subtotal = ordenesProvider.getCustomerSubtotalOfToday(customer.id); // Obtener subtotal
                  final ordenes = ordenesProvider.getOrdersForCustomer(customer.id); // Obtén las órdenes del cliente
                  final control = ordenes.isNotEmpty ? ordenes[0].control : 'N/A'; // Muestra el control de la primera orden, o 'N/A' si no hay órdenes

                  // Cambiar el fondo de cada línea de manera alterna
                  final backgroundColor = index % 2 == 0
                      ? const Color.fromRGBO(177, 255, 46, 1).withOpacity(1)
                      : const Color.fromRGBO(177, 255, 46, 1).withOpacity(1);

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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customer.razons,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    customer.sucursal,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'SUBTOTAL: \$ ${subtotal.toStringAsFixed(2)}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '# CONTROL: $control',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                    ),
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
