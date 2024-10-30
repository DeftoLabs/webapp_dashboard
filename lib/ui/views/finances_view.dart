import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/finance_datasource.dart';
import 'package:web_dashboard/datatables/taxsales_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/modals/finance_modal.dart';

class FinancesView extends StatelessWidget {
  const FinancesView({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);
    final financesDataSource = FinanceDataSource(financeProvider.finances);


    final taxsalesProvider = Provider.of<TaxSalesProvider>(context);
    final taxSalesDataSource = TaxSalesDataSource(taxsalesProvider.taxsales);

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

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
                  ),
                SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),
              const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              if (financesDataSource.finances.isEmpty)
                 Padding(
                  padding: const EdgeInsets.all(20),
                   child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                       height: 50,
                       width: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(177, 255, 46, 100),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.6,
                        )),
                      child: TextButton(
                        child: Text(
                          'Create Currency',
                          style: GoogleFonts.plusJakartaSans(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const FinanceModal();
                              },
                            );
                        },
                      ),
                    ),
                                   ),
                 ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text('CURRENCY', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Container(
               width: MediaQuery.of(context).size.width * 0.9,
                height: 150,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow( 
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ]),
                    child: SingleChildScrollView(
                      scrollDirection: isSmallScreen ? Axis.horizontal : Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                            'PRIMARY',
                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            '',
                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'SECONDARY',
                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            '',
                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'EDIT',
                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          )),
                        ],
                        rows: financesDataSource.finances
                            .map((finance) => DataRow(
                                  cells: [
                                    DataCell(Text(finance.mainCurrencyname)),
                                    DataCell(Text(finance.mainCurrencysymbol)),
                                    DataCell(Text(finance.secondCurrencyname)),
                                    DataCell(Text(finance.secondCurrencysymbol)),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.edit_outlined),
                                        onPressed: () {
                                          NavigationService.replaceTo(
                                              '/dashboard/settings/finance/${finance.id}');
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Text('TAX', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('SALES TAX',
                           style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)
                          ),
                        )
                        ),
                        Expanded(child: Center(
                          child: Text('BUSINESS TAXES', 
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                        ))
                    ],
                  ),
                Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Ajusta el margen de 10 píxeles
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: isSmallScreen ? Axis.horizontal : Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'TAX',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '%',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'EDIT',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: taxSalesDataSource.taxsales.map(
                (taxsales) => DataRow(
                  cells: [
                    DataCell(Text(taxsales.taxname)),
                    DataCell(Text(taxsales.taxnumber.toString())),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          NavigationService.replaceTo('/dashboard/settings/finance/taxsales/${taxsales.id}');
                        },
                      ),
                    ),
                  ],
                ),
              ).toList(),
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Ajusta el margen de 10 píxeles
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: isSmallScreen ? Axis.horizontal : Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'TAX',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '%',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'EDIT',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: taxSalesDataSource.taxsales.map(
                (taxsales) => DataRow(
                  cells: [
                    DataCell(Text(taxsales.taxname)),
                    DataCell(Text(taxsales.taxnumber.toString())),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          NavigationService.replaceTo('/dashboard/settings/finance');
                        },
                      ),
                    ),
                  ],
                ),
              ).toList(),
            ),
          ),
        ),
      ),
    ),
  ],
)

                 
                ],
              ),
              
            ],
          ),
        );
      },
    );
  }
}
