
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            Row(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Routes View',
                    style: CustomLabels.h1,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(177, 255, 46, 100),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 0.6,
                      )),
                    child: TextButton.icon(
                      label: Text(
                        'Create e New Route',
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () {
                        
                      },
                      icon: const Icon(
                        Icons.route_rounded,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),

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