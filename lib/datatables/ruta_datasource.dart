import 'package:flutter/material.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class RutaDatasource extends DataTableSource {

  final List<Ruta> rutas;

  RutaDatasource(this.rutas);

  @override
  DataRow getRow(int index) {

    final Ruta ruta = rutas[index];


    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text((index + 1).toString(),)),
        DataCell( Text( ruta.codigoRuta)),
        DataCell( Text( ruta.nombreRuta)),
        DataCell( Text( ruta.clientes.length.toString())),
        DataCell( Text( ruta.usuarioZona.nombre)),
        DataCell( 
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              NavigationService.replaceTo('/dashboard/routes/${ruta.id}');
            },
            )
        ),

      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rutas.length;

  @override
  int get selectedRowCount => 0;
}