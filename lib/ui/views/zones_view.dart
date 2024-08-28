
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/zones_datasource.dart';
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Zones View', style: CustomLabels.h1,),
          const SizedBox(height: 10),

          PaginatedDataTable(
            sortAscending: routesProvider.ascending,
            sortColumnIndex: routesProvider.sortColumnIndex,
            columns: [
              DataColumn(label: const Text('Code'), onSort: (colIndex, _){
                routesProvider.sortColumnIndex = colIndex;
                routesProvider.sort<String>((zona) => zona.codigo ); 
              }),
              DataColumn(label: const Text('Zone Name'), onSort: (colIndex, _){
                routesProvider.sortColumnIndex = colIndex;
                routesProvider.sort<String>((zona) => zona.nombrezona ); 
              }),
              const DataColumn(label: Text('Description')),
              const DataColumn(label: Text('Edit', textAlign: TextAlign.right), numeric: true),
            ], 
            
            source: routesDataSource,
            header: const Text('List of Zones', maxLines: 2),
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
                  text:'Create a Zone', 
                  icon: Icons.add_outlined)
              ],
            )
        ],
      )
    );
  }
}