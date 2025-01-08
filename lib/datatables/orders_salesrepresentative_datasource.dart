

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class OrdersSalesRepresentativeDataSource extends DataTableSource {

  final List<Ordenes> ordenes;

  OrdersSalesRepresentativeDataSource(this.ordenes);

  @override
  DataRow getRow(int index) {

    final ordenesOrdenadas = List.from(ordenes)..sort((a, b) => b.fechacreado.compareTo(a.fechacreado));

    final Ordenes orden = ordenesOrdenadas[index];

    final formattedDate = DateFormat('dd/MM/yy').format(orden.fechacreado);
    
    String clienteNombre = '';
      if(orden.clientes.isNotEmpty) {
        clienteNombre = orden.clientes.first.nombre;
      }
    String clienteSucursal = '';
      if(orden.clientes.isNotEmpty) {
        clienteSucursal = orden.clientes.first.sucursal;
      }

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(orden.control ,style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(formattedDate, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(clienteNombre, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(clienteSucursal, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text(orden.status, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
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