
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/customers_datasource.dart';
import 'package:web_dashboard/providers/customers_provider.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

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
            DataColumn(label: const Text('Name'), onSort: (colIndex, _) {
              customerProvider.sortColumnIndex = colIndex;
              customerProvider.sort((customer)=> customer.nombre);
            }),
            const DataColumn(label: Text('Branch')),
            const DataColumn(label: Text('Phone')),
            const DataColumn(label: Text('Email')),
            const DataColumn(label: Text('Sales')),
            const DataColumn(label: Text('Edit')),

          ], 
          source: customersDataSource,
          onPageChanged: (page) {

          },
          )
        ],
      )
    );
  }
}