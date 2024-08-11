

import 'package:flutter/material.dart';

class CustomersDatasource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
   
   return DataRow.byIndex(
    index: index,
    cells: [
      DataCell(Text('cell #$index')),
      DataCell(Text('cell #$index')),
      DataCell(Text('cell #$index')),
      DataCell(Text('cell #$index')),
      DataCell(Text('cell #$index')),
      DataCell(Text('cell #$index')),

    ]
    );
  
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;

}