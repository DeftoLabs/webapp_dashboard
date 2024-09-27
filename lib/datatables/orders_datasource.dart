

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdersDataSource extends DataTableSource {

  final List<Ordenes> ordenes;

  OrdersDataSource(this.ordenes);

  @override
  DataRow getRow(int index) {

    final Ordenes orden = ordenes[index];
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('cell #$index')),
        DataCell(Text('cell #$index')),
        DataCell(Text('cell #$index')),
        DataCell(Text('cell #$index')),
        DataCell(Text('cell #$index')),
        DataCell(Text('cell #$index')),
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