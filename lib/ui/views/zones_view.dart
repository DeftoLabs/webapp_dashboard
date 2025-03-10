
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/zones_datasource.dart';
import 'package:web_dashboard/l10n/app_localizations.dart';
import 'package:web_dashboard/providers/zones_providers.dart';
import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';
import 'package:web_dashboard/ui/modals/zone_modal.dart';



class ZonesView extends StatelessWidget {
  const ZonesView({super.key});

  @override
  Widget build(BuildContext context) {

    final routesProvider = Provider.of<ZonesProviders>(context);

    final routesDataSource = ZonesDataSource( routesProvider.zonas );

    final localization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(localization.zones, style: CustomLabels.h1,),
          const SizedBox(height: 10),

          PaginatedDataTable(
            sortAscending: routesProvider.ascending,
            sortColumnIndex: routesProvider.sortColumnIndex,
            columns: [
              DataColumn(label: Text(localization.code), onSort: (colIndex, _){
                routesProvider.sortColumnIndex = colIndex;
                routesProvider.sort<String>((zona) => zona.codigo ); 
              }),
              DataColumn(label: Text(localization.zona), onSort: (colIndex, _){
                routesProvider.sortColumnIndex = colIndex;
                routesProvider.sort<String>((zona) => zona.nombrezona ); 
              }),
              DataColumn(label: Text(localization.descriptionm)),
              DataColumn(label: Text(localization.edit, textAlign: TextAlign.right), numeric: true),
            ], 
            
            source: routesDataSource,
            header: Text(localization.listofzone, maxLines: 2),
            onPageChanged: (page) {

            },
              actions: [
                CustomIconButton(
                  onPressed: (){

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ZoneModal();
                      },
                    );
                //NavigationService.replaceTo('/dashboard/newroute');
                  }, 
                  text:localization.createazone, 
                  icon: Icons.add_outlined)
              ],
            )
        ],
      )
    );
  }
}