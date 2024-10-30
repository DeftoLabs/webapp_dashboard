

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/taxsales.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class TaxSalesDataSource extends DataTableSource {

  final List<TaxSales> taxsales;

  TaxSalesDataSource(this.taxsales);

  @override
  DataRow getRow(int index) {

    final taxsale = taxsales[index];
    
    return DataRow.byIndex(
      index: index,
      cells:[
        DataCell(Text(taxsale.taxname)),
        DataCell(Text(taxsale.taxnumber.toString())),
                DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined), 
            onPressed: (){
               NavigationService.replaceTo('/dashboard/settings/finance');
            },)
        ),    

      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => taxsales.length;

  @override
  int get selectedRowCount => 0;

}