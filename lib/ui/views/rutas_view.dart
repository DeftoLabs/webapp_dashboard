
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/ruta_datasource.dart';
import 'package:web_dashboard/providers/ruta_provider.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class RutasView extends StatelessWidget {
  const RutasView({super.key});

  @override
  Widget build(BuildContext context) {

    final rutasProvider = Provider.of<RutaProvider>(context);

    final routeDataSource = RutaDatasource( rutasProvider.rutas );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Routes View', style: CustomLabels.h1,),

          const SizedBox(height: 20),

          PaginatedDataTable(
            sortAscending: rutasProvider.ascending,
            sortColumnIndex: rutasProvider.sortColumnIndex,
            columns: [
              const DataColumn(label: Text('Route')),
              DataColumn(label: const Text('Code', style: TextStyle(
                fontWeight: FontWeight.bold)), 
              onSort: (colIndex, _) {
                rutasProvider.sortColumnIndex = colIndex;
                rutasProvider.sort<String>((ruta) => ruta.codigoRuta);
              }),
              DataColumn(label: const Text('Route Name', style: TextStyle(fontWeight: FontWeight.bold)), 
              onSort: (colIndex, _) {
                rutasProvider.sortColumnIndex = colIndex;
                rutasProvider.sort<String>((ruta) => ruta.nombreRuta);
              }),
              const DataColumn(label: Text('Customers')),
              const DataColumn(label: Text('Sales Representative')),
              const DataColumn(label: Text('Edit')),
            ], 
            source: routeDataSource,
            onPageChanged: (page) {

            },
            )

        ],
      )
    );
  }
}