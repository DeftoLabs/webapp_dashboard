
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

          const SizedBox(height: 10),

          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Image')),
              DataColumn(label: Text('Code')),
              DataColumn(label: Text('Route Name')),
              DataColumn(label: Text('Customers')),
              DataColumn(label: Text('Sales Representative')),
              DataColumn(label: Text('Edit')),
            ], 
            source: routeDataSource)

        ],
      )
    );
  }
}