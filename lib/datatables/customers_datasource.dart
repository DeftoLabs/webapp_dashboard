

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/customers.dart';

class CustomersDatasource extends DataTableSource {

  final List<Customer> customers;

  CustomersDatasource(this.customers);

  @override
  DataRow? getRow(int index) {

    final customer = customers[index];
   
   return DataRow.byIndex(
    index: index,
    cells: [
      DataCell(Text(customer.codigo)),
      DataCell(Text(customer.nombre)),
      DataCell(Text(customer.sucursal)),
      DataCell(Text(customer.telefono)),
      DataCell(Text(customer.correo)),
      DataCell(Text(customer.usuario.nombre)),

    ]
    );
  
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => customers.length;

  @override
  int get selectedRowCount => 0;

}