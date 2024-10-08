
import 'package:flutter/material.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class FinanceDataSource extends DataTableSource {

  final List<Finance> finances;

  FinanceDataSource(this.finances);
  
  @override
  DataRow getRow(int index) {

    final Finance finance = finances[index];
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(finance.mainCurrency.name)),
        DataCell(Text(finance.secondaryCurrency.name)),  
        DataCell(Text(finance.tax1.first.percentage.toString())),
        DataCell(Text(finance.tax2.first.percentage.toString())), 
        DataCell(Text(finance.tax3.first.percentage.toString())), 
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined), 
            onPressed: (){
               NavigationService.replaceTo('/dashboard/settings/finance/${finance.id}');
            },)
        ),    
        ]
    
      );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => finances.length;

  @override
  int get selectedRowCount => 0;

}