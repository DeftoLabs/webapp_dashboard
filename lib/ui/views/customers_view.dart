
import 'package:flutter/material.dart';
import 'package:web_dashboard/datatables/customers_datasource.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';


class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {

    final customersDataSource = CustomersDatasource();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Customers View', style: CustomLabels.h1,),

          const SizedBox(height: 10),

         PaginatedDataTable(
          columns: const [
            DataColumn(label: Text('Code')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Branch')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Sales')),

          ], 
          source: customersDataSource)
        ],
      )
    );
  }
}