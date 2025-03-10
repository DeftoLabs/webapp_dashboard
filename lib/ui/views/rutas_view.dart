
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/ruta_datasource.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/providers/ruta_provider.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'package:web_dashboard/ui/modals/ruta_modal.dart';


class RutasView extends StatelessWidget {
  const RutasView({super.key});

  @override
  Widget build(BuildContext context) {

    final rutasProvider = Provider.of<RutaProvider>(context);

    final routeDataSource = RutaDatasource( rutasProvider.rutas );

    final localization = AppLocalizations.of(context)!;

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
                    localization.routeview,
                    style: CustomLabels.h1,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:  const Color.fromRGBO(177, 255, 46, 1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 0.6,
                      )),
                    child: TextButton.icon(
                      label: Text(
                        localization.createnewroute,
                        style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () {
                          showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RutaModal();
                      },
                    );
                        
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
              const DataColumn(label: Text('#')),
              DataColumn(label: Text(localization.code, 
              style: const TextStyle(
                fontWeight: FontWeight.bold)), 
              onSort: (colIndex, _) {
                rutasProvider.sortColumnIndex = colIndex;
                rutasProvider.sort<String>((ruta) => ruta.codigoRuta);
              }),
              DataColumn(label: Text(localization.routename, 
              style: const TextStyle(fontWeight: FontWeight.bold)), 
              onSort: (colIndex, _) {
                rutasProvider.sortColumnIndex = colIndex;
                rutasProvider.sort<String>((ruta) => ruta.nombreRuta);
              }),
              DataColumn(label: Text(localization.customer)),
              DataColumn(label: Text(localization.salesrepresentative)),
              DataColumn(label: Text(localization.edit)),
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