import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:web_dashboard/models/payment.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class PaymentsSalesRepresentativeDataSource extends DataTableSource {

final List<Payment> payments;

  PaymentsSalesRepresentativeDataSource(this.payments);

  @override
  DataRow getRow(int index) {

     final paymentOrdenadas = List.from(payments)..sort((a, b) => b.fechacreacion.compareTo(a.fechacreacion));

    final Payment payment = paymentOrdenadas[index];

    final formattedDate = DateFormat('dd/MM/yy').format(payment.fechacreacion);

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(formattedDate, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
        DataCell(Text (payment.numerocontrol, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text (payment.type, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
        DataCell(Text (payment.cliente.nombre, style: GoogleFonts.plusJakartaSans(fontSize: 12))),
        DataCell(Text (payment.currencySymbol, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold))),
        DataCell(Text (payment.monto.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold))),
        DataCell(IconButton(
          onPressed: (){
              NavigationService.replaceTo('/dashboard/payments/${payment.id}');
          }, 
          icon: const Icon(Icons.edit_outlined) )),
      ]
      );
   
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => payments.length;

  @override
  int get selectedRowCount => 0;

}