

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class OrdersSearchDateDataSource extends DataTableSource {

  final List<Ordenes> ordenes;

  OrdersSearchDateDataSource(this.ordenes);

  @override
  DataRow getRow(int index) {

    final ordenesOrdenadas = List.from(ordenes)..sort((a, b) => b.fechacreado.compareTo(a.fechacreado));

    final Ordenes orden = ordenesOrdenadas[index];

    final formattedDate = DateFormat('dd/MM/yy').format(orden.fechacreado);
    final formattedDateDelivery = DateFormat('dd/MM/yy').format(orden.fechaentrega);
    
    String clienteNombre = '';
      if(orden.clientes.isNotEmpty) {
        clienteNombre = orden.clientes.first.nombre;
      }
    String clienteSucursal = '';
      if(orden.clientes.isNotEmpty) {
        clienteSucursal = orden.clientes.first.sucursal;
      }
    String salesRepresentative = '';
      if(orden.ruta.isNotEmpty) {
        salesRepresentative = orden.ruta.first.usuarioZona.nombre;
      }
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(orden.control ,style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(formattedDate, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(formattedDateDelivery, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
        DataCell(Text(clienteNombre, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(clienteSucursal, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(orden.status, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(salesRepresentative, style: GoogleFonts.plusJakartaSans(fontSize: 12) )),
   DataCell(
          IconButton(icon: const Icon(Icons.edit_outlined), 
          onPressed: (){
            NavigationService.replaceTo('/dashboard/orders/${orden.id}');
          },)),
      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => ordenes.length;

  @override
  int get selectedRowCount => 0;
}