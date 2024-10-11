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
              const SizedBox(height: 60),
              SingleChildScrollView(
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
                      'SECONDARY',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'TAX',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      '',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'TAX',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      '',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'TAX',
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
                              DataCell(Text(finance.secondCurrencyname)),
                              DataCell(Text('${finance.tax1number.toString()} %')),
                              DataCell(Text(
                                finance.tax1name,
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text('${finance.tax2number.toString()} %')),
                              DataCell(Text(
                                finance.tax2name,
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(finance.tax3number.toString())),
                              DataCell(Text(
                                finance.tax3name,
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold),
                              )),
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
              const Divider(),
              const SizedBox(height: 20),
              
            ],
          ),
        );
      },
    );
  }
}
