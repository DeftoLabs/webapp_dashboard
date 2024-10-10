
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        DataCell(Text(finance.mainCurrencyname)),
        DataCell(Text(finance.secondCurrencyname)), 
        DataCell(Text('${finance.tax1number.toString()} %')),
        DataCell(Text(finance.tax1name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),)),
        DataCell(Text('${finance.tax2number.toString()} %')), 
        DataCell(Text(finance.tax2name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),)),
        DataCell(Text(finance.tax3number.toString())), 
        DataCell(Text(finance.tax3name, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),)),
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