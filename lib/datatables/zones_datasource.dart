import 'package:flutter/material.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class ZonesDataSource extends DataTableSource {

  final List<Zona> zonas;

  ZonesDataSource(this.zonas);

  @override
  DataRow? getRow(int index) {

    final Zona zona = zonas[index];

    return  DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(zona.codigo)),
        DataCell(Text(zona.nombrezona)),
        DataCell(Text(zona.descripcion)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: (){
              NavigationService.replaceTo('/dashboard/zones/${zona.id}');
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