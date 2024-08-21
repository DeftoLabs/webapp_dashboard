
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/customers_datasource.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {


  @override
  Widget build(BuildContext context) {

    final customerProvider = Provider.of<CustomersProvider>(context);

    final customersDataSource = CustomersDatasource( customerProvider.customers );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Customers View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

         PaginatedDataTable(
          sortAscending: customerProvider.ascending,
          sortColumnIndex: customerProvider.sortColumnIndex,
          columns: [
            DataColumn(label: const Text('Code'), onSort: (colIndex, _) {
              customerProvider.sortColumnIndex = colIndex;
              customerProvider.sort((customer)=> customer.codigo);
            }),
            DataColumn(label: const Text('Legal Name'), onSort: (colIndex, _) {
              customerProvider.sortColumnIndex = colIndex;
              customerProvider.sort((customer)=> customer.nombre);
            }),
            const DataColumn(label: Text('Branch')),
            const DataColumn(label: Text('Zone')),
            const DataColumn(label: Text('Edit')),

          ], 
          source: customersDataSource,
          header: const Text('', maxLines:2),
            onPageChanged: ( page ) {

            },
          actions: [
            CustomIconButton(
              onPressed: (){
                NavigationService.replaceTo('/dashboard/customers/newcustomer');
              }, 
              text: 'Create a Customer', 
              icon: Icons.add_outlined)
          ],
         
          )
        ],
      )
    );
  }
}