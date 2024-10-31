

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/taxoperation.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class TaxOperationDataSource extends DataTableSource {

  final List<TaxOperation> taxoperations;

  TaxOperationDataSource(this.taxoperations);

  @override
  DataRow getRow(int index) {

    final taxoperation = taxoperations[index];
    
    return DataRow.byIndex(
      index: index,
      cells:[
        DataCell(Text(taxoperation.taxname)),
        DataCell(Text(taxoperation.taxnumber.toString())),
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
  int get rowCount => taxoperations.length;

  @override
  int get selectedRowCount => 0;

}