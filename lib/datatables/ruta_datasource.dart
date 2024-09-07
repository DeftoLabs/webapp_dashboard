import 'package:flutter/material.dart';
import 'package:web_dashboard/models/ruta.dart';

class RutaDatasource extends DataTableSource {

  final List<Ruta> rutas;

  RutaDatasource(this.rutas);

  @override
  DataRow getRow(int index) {

    final Ruta ruta = rutas[index];

    const image = Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35);

    return DataRow.byIndex(
      index: index,
      cells: [
        const DataCell( 
          ClipOval( child: image) ),
        DataCell( Text( ruta.codigoRuta)),
        DataCell( Text( ruta.nombreRuta)),
        DataCell( Text( ruta.clientes.length.toString())),
        DataCell( Text( ruta.usuarioZona.nombre)),
        DataCell( 
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {

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