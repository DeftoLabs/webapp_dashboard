import 'package:flutter/material.dart';

class CategoriesDTS extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells:[ 
        DataCell (Text('Cell # 01 index:$index')),
        DataCell (Text('Cell # 02 index:$index')),
        DataCell (Text('Cell # 03 index:$index')),        
        DataCell (Text('Cell # 04 index:$index')),
      ]
       );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 1000;

  @override
  int get selectedRowCount => 0;

}