

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/bank.dart';

class BankDataSource extends DataTableSource {

  final List<Bank> banks;

  BankDataSource(this.banks);

  @override
  DataRow getRow(int index) {

    final Bank bank = banks[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(bank.nombre)),
        DataCell(Text(bank.titular)),
        DataCell(Text(bank.numero)),
        DataCell(Text(bank.currencySymbol)),
        DataCell(
         IconButton(onPressed: (){}, icon: const Icon(Icons.edit_outlined))
        ),
      ]);
  
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => banks.length;

  @override
  int get selectedRowCount => 0;

}