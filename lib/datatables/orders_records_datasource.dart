import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdersRecordsDataSource extends DataTableSource {

  final List<Ordenes> ordenes;

  OrdersRecordsDataSource( this.ordenes);

  @override
  DataRow getRow(int index) {

      final Ordenes orden = ordenes[index];

      final formattedDate = DateFormat('dd/MM/yy').format(orden.fechacreado);

      String clienteNombre = '';
      if(orden.clientes.isNotEmpty) {
        clienteNombre = orden.clientes.first.nombre;
      }


    
    return DataRow.byIndex(
      
      index: index,
      cells: [
        DataCell(Text(orden.control)),
        DataCell(Text(formattedDate)),
        DataCell(Text(clienteNombre)),
        DataCell(Text('')),
        DataCell(Text(orden.status)),
        DataCell(Text(orden.ruta.first.usuarioZona.nombre)),
        DataCell(
          IconButton(icon: const Icon(Icons.edit_outlined), 
          onPressed: (){

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