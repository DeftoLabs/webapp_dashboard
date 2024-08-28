

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/services/navigation_service.dart';

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
      DataCell(Text(customer.razons)),
      DataCell(Text(customer.sucursal)),
      DataCell(Text(customer.zona.nombrezona)),
      DataCell(IconButton(
        icon: const Icon(Icons.edit_outlined),
        onPressed: (){
          NavigationService.replaceTo('/dashboard/customers/${customer.id}');
        },
        ))

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