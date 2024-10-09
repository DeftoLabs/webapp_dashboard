
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/finance_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';


class FinancesView extends StatelessWidget {
  const FinancesView({super.key});

  @override
  Widget build(BuildContext context) {

    final financeProvider = Provider.of<FinanceProvider>(context);
    final financesDataSource = FinanceDataSource(financeProvider.finances);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
             Row(
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      NavigationService.navigateTo('/dashboard/settings');
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Column(
                    children: [
                       const SizedBox(height: 20),
                      Text(
                        'Finance Settings',
                        style: GoogleFonts.plusJakartaSans(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          const SizedBox(height: 20),
          PaginatedDataTable(
            columns:const [
              DataColumn(label: Text('MAIN CURRENCY')),
              DataColumn(label: Text('SECOND CURRENCY')),
              DataColumn(label: Text('TAX')),
              DataColumn(label: Text('TAX')),
              DataColumn(label: Text('TAX')),
              DataColumn(label: Text('EDIT')),
            ], 
            source: financesDataSource)

        ],
      )
    );
  }
}