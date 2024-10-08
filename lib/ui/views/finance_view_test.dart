
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';


class FinanceViewTest extends StatefulWidget {
  
  final String id;
  
  const FinanceViewTest({super.key, required this.id});

  @override
  State<FinanceViewTest> createState() => _FinanceViewTestState();
}

class _FinanceViewTestState extends State<FinanceViewTest> {

  @override
  Widget build(BuildContext context) {

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
                  child: Text(
                    'Finance Settings',
                    style: GoogleFonts.plusJakartaSans(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          const SizedBox(height: 20),
          const FinanceViewBody(),
          const SizedBox(height: 20),
          const TaxesViewBody()
        ],
      )
    );
  }
}

class TaxesViewBody extends StatefulWidget {
  const TaxesViewBody({super.key});

  @override
  State<TaxesViewBody> createState() => _TaxesViewBodyState();
}

class _TaxesViewBodyState extends State<TaxesViewBody> {
  Currency? mainCurrency;
  Currency? secondaryCurrency;

  @override
  Widget build(BuildContext context) {

    final financeProvider = Provider.of<FinanceProvider>(context);
    final finance = financeProvider.finances.isNotEmpty ? financeProvider.finances[0] : null;

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(350),
        1: FixedColumnWidth(350),
      },
      children: [
        TableRow(
          children: [
            Container(
              width: 250,
              height: 330,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  )
                ]
              ),
              child: Column(
                children: [
                  Form(
                   //key: financeProvider.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                                    Text(
                  'TAXES',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Divider(
                  indent: 40,
                  endIndent: 40,
                  color: Colors.black),
                  const SizedBox(height: 10),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TAX 01 %', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 70, 
                      height: 40, 
                      child: TextFormField(
                       initialValue:  finance != null 
                        ? finance.tax1.first.percentage.toString() 
                        : '', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold) ,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                           contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) return 'Enter TAX %';
                          final parsedValue = int.tryParse(value);
                            if (parsedValue == null) {
                              return 'Only numbers';
                            }
                            if (parsedValue > 99) {
                              return 'TAX cannot exceed 99%';
                            }
                          if(value.length>2) return 'Max 2 digits';
                          return null;
                        },
                        onChanged: (value) {
                          final parsedValue = double.tryParse(value);
                            if (parsedValue != null) {
                            finance!.tax1.first.percentage = parsedValue;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('TYPE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                     SizedBox(
                      width: 80, 
                      height: 40, 
                      child: TextFormField(
                      initialValue: finance != null 
                        ? finance.tax1.first.name 
                        : 'VAT',  style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                           contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TAX 02 %', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 70, 
                      height: 40, 
                      child: TextFormField(
                      initialValue: finance != null 
                        ? finance.tax2.first.percentage.toString() 
                        : 'TAX 02', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                           contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('TYPE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                     SizedBox(
                      width: 80, 
                      height: 40, 
                      child: TextFormField(
                      initialValue: finance != null 
                        ? finance.tax2.first.name 
                        : 'VAT',  style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                        ),
                      ),
                    ),
                  ],
                  ),
                   const SizedBox(height: 20),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TAX 03 %', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 70,
                      height: 40, 
                      child: TextFormField(
                      initialValue: finance != null 
                        ? finance.tax3.first.percentage.toString() 
                        : 'TAX 03', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                           contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('TYPE', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                     SizedBox(
                      width: 80, // Estableces el ancho
                      height: 40, // Estableces el alto
                      child: TextFormField(
                      initialValue: finance != null 
                        ? finance.tax3.first.name 
                        : 'VAT',  style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                        ),
                      ),
                    ),
                  ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                  height: 50,
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 200, 83, 1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromRGBO(177, 255, 46, 100),
                        width: 2,
                      )),
                  child: TextButton(
                    child:  Text(
                      'SAVE',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),  
                   onPressed: () {
                   // financeProvider.updateFinanceTax();
                   }),
                          ),
                                  ],
                                ),
                              )],
                      ))
                  ,
            Container(
              height: 330,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  ),
                ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
               
                  const SizedBox(height: 20),
                  ]
                  )
            ),
              Container(
              height: 330,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  ),
                ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  const SizedBox(height: 20),
                  ]
                  )
            )
          ],
        ),
      ],
    );
  }
}


class FinanceViewBody extends StatefulWidget {
  
  const FinanceViewBody({super.key});

  @override
  State<FinanceViewBody> createState() => _FinanceViewBodyState();
}

class _FinanceViewBodyState extends State<FinanceViewBody> {
  Currency? mainCurrency;
  Currency? secondaryCurrency;

  @override
  Widget build(BuildContext context) {

    final financeProvider = Provider.of<FinanceProvider>(context);
    final finance = financeProvider.finances.isNotEmpty ? financeProvider.finances[0] : null;


    return Table(
      columnWidths: const {
        0: FixedColumnWidth(500),
      },
      children: [
        TableRow(
          children: [
            Container(
              width: 250,
              height: 350,
               margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  )
                ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Select the Currency',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                  indent: 40,
                  endIndent: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Text('Main Currency:', style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250, 
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,// Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        textStyle: GoogleFonts.plusJakartaSans(fontSize: 12), // Estilo de texto
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Padding interno
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                          side: const BorderSide(color:  Color.fromRGBO(0, 200, 83, 1),), // Color del borde (opcional)
                        ),
                      ),
                      onPressed: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (Currency currency) {
                            setState(() {
                              mainCurrency = currency;
                            });
                          },
                        );
                      },
                      child: Text(mainCurrency != null
                          ? 'Main: ${mainCurrency!.name} (${mainCurrency!.symbol})'
                          : 'Select Main Currency'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Secondary Currency:', style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250, 
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,// Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        textStyle: GoogleFonts.plusJakartaSans(fontSize: 12), // Estilo de texto
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Padding interno
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                          side: const BorderSide(color:  Color.fromRGBO(0, 200, 83, 1),), // Color del borde (opcional)
                        ),
                      ),
                      onPressed: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (Currency currency) {
                            setState(() {
                              secondaryCurrency = currency;
                            });
                          },
                        );
                      },
                      child: Text(secondaryCurrency != null
                          ? 'Secondary: ${secondaryCurrency!.name} (${secondaryCurrency!.symbol})'
                          : 'Select Secondary Currency'),
                    ),
                  ),
                  const SizedBox(height: 20),
                    Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 200, 83, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(177, 255, 46, 100),
                          width: 2,
                        )),
                    child: TextButton(
                      child:  Text(
                        'SAVE',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),  
                     onPressed: () {

                     }),
                            ),
                ],
              ),
            ),
            SizedBox(
              child: finance == null ? 
              WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: 100,
                child: const CircularProgressIndicator(
            color: Color.fromRGBO(255, 0, 200, 0.612), strokeWidth: 4.0),
              )
            ) : 
              const GeneralInfo(), 
            )
          ],
        ),
      ],
    );
  }
}

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final financeProvider = Provider.of<FinanceProvider>(context);
    final finance = financeProvider.finances.isNotEmpty ? financeProvider.finances[0] : null;

    return Container(
      height: 350,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3)
          ),
        ]
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'General Info',
            style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Divider(
          indent: 40,
          endIndent: 40,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text('Main Currency:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance!.mainCurrency.name),
              const SizedBox(width: 10),
              Text(finance.mainCurrency.symbol, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
           Row(
            children: [
              const SizedBox(width: 20),
              Text('Secondary Currency:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.secondaryCurrency.name),
              const SizedBox(width: 10),
              Text(finance.secondaryCurrency.symbol, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
           const SizedBox(height: 30),
           Row(
            children: [
              const SizedBox(width: 20),
              Text('TAX:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.tax1.first.percentage.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 14)),
              const SizedBox(width: 05),
              Text('%', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.tax1.first.name, style:GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),),
            ],
          ),
           const SizedBox(height: 10),
           Row(
            children: [
              const SizedBox(width: 20),
              Text('TAX:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.tax2.first.percentage.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 14)),
              const SizedBox(width: 05),
              Text('%', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.tax2.first.name, style:GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),),
            ],
          ),
            const SizedBox(height: 10),
           Row(
            children: [
              const SizedBox(width: 20),
              Text('TAX:', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.tax3.first.percentage.toString(), style: GoogleFonts.plusJakartaSans(fontSize: 14)),
              const SizedBox(width: 05),
              Text('%', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(finance.tax3.first.name, style:GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),),
            ],
          ),
          ]
          )
    );
  }
}
