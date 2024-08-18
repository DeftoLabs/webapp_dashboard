import 'package:flutter/material.dart';
import 'package:web_dashboard/models/zona.dart';

class RoutesDataSource extends DataTableSource {

  final List<Zona> zonas;

  RoutesDataSource(this.zonas);

  @override
  DataRow? getRow(int index) {

    final Zona zona = zonas[index];

    return  DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(zona.codigo)),
        DataCell(Text(zona.nombrezona)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: (){

            },
            )
        ),
      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => zonas.length;

  @override
  int get selectedRowCount => 0;


}