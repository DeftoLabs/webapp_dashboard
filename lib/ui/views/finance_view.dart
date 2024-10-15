import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';

class FinanceView extends StatefulWidget {
  final String id;

  const FinanceView({super.key, required this.id});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {
  Finance? finance;

  @override
  void initState() {
    super.initState();
    final financeProvider =
        Provider.of<FinanceProvider>(context, listen: false);
    final financeFormProvider =
        Provider.of<FinanceFormProvider>(context, listen: false);

    financeProvider.getFinanceById(widget.id).then((financeDB) {
      financeFormProvider.finance = financeDB;
      setState(() {
        finance = financeDB;
      });
    });
  }

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
                      NavigationService.navigateTo(
                          '/dashboard/settings/finance');
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
            if (finance == null)
              WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(
                    color: Color.fromRGBO(255, 0, 200, 0.612),
                    strokeWidth: 4.0),
              )),
            if (finance != null) ...[
              const SizedBox(height: 20),
              const FinanceViewBody(),
              const SizedBox(height: 20),
              const TaxesViewBody(),
            ]
          ],
        ));
  }
}

class FinanceViewBody extends StatefulWidget {
  const FinanceViewBody({super.key});

  @override
  State<FinanceViewBody> createState() => _FinanceViewBodyState();
}

class _FinanceViewBodyState extends State<FinanceViewBody> {
  String? mainCurrencyname;
  String? mainCurrencysymbol;
  String? secondCurrencyname;
  String? secondCurrencysymbol;

  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context);
    final finance = financeFormProvider.finance!;

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
                        offset: const Offset(0, 3))
                  ]),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Select the Currency',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    indent: 40,
                    endIndent: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Text('Main Currency:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 16), // Estilo de texto
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 20.0), // Padding interno
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Bordes redondeados
                          side: const BorderSide(
                            color: Color.fromRGBO(0, 200, 83, 1),
                          ), // Color del borde (opcional)
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
                              mainCurrencyname = currency.name;
                              mainCurrencysymbol = currency.symbol;
                            });
                          },
                        );
                      },
                     child: Text(mainCurrencyname != null
                          ? '$mainCurrencyname ($mainCurrencysymbol)'
                          : 'Select Currency'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Secondary Currency:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Color de fondo
                        foregroundColor: Colors.white, // Color del texto
                        textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 16), // Estilo de texto
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 20.0), // Padding interno
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Bordes redondeados
                          side: const BorderSide(
                            color: Color.fromRGBO(0, 200, 83, 1),
                          ), // Color del borde (opcional)
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
                              secondCurrencyname = currency.name;
                              secondCurrencysymbol = currency.symbol;
                            });
                          },
                        );
                      },
                      child: Text(secondCurrencyname != null
                          ? '$secondCurrencyname ($secondCurrencysymbol)'
                          : 'Select Currency'),
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
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                         onPressed: () async {
                                if (financeFormProvider.validForm()) {
                                    financeFormProvider.setMainCurrency(
                                        name: mainCurrencyname.toString(),
                                        symbol: mainCurrencysymbol.toString(),
                                    );
                                     financeFormProvider.setSecondaryCurrency(
                                          name: secondCurrencyname.toString(),
                                          symbol: secondCurrencysymbol.toString(),
                                    );

                                  final saved = await financeFormProvider.updateCurrency();
                                  if (saved) {
                                    NotificationService.showSnackBa('Currency Updated');
                                    if (!context.mounted) return;
                                    Provider.of<FinanceProvider>(context,listen: false).getFinance();
                                    NavigationService.replaceTo('/dashboard/settings/finance');
                                  } else {
                                    NotificationService.showSnackBarError(
                                        'Error: The Currencys were not updated');
                                  }
                                } else {
                                  NotificationService.showSnackBarError(
                                      'Please fill all fields correctly');
                                }
                              },
                        ),
                  ),
                ],
              ),
            ),
            Container(
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
                          offset: const Offset(0, 3)),
                    ]),
                child: Column(children: [
                  const SizedBox(height: 20),
                  Text(
                    'General Info',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                      Text('Main Currency:',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(finance.mainCurrencyname),
                      const SizedBox(width: 10),
                      Text(finance.mainCurrencysymbol,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text('Secondary Currency:',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(finance.secondCurrencyname),
                      const SizedBox(width: 10),
                      Text(finance.secondCurrencysymbol,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text('TAX:',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(finance.tax1number.toString(),
                          style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                      const SizedBox(width: 05),
                      Text('%',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(
                        finance.tax1name,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text('TAX:',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(finance.tax2number.toString(),
                          style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                      const SizedBox(width: 05),
                      Text('%',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(
                        finance.tax2name,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text('TAX:',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(finance.tax3number.toString(),
                          style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                      const SizedBox(width: 05),
                      Text('%',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(
                        finance.tax3name,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]))
          ],
        ),
      ],
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
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context);
    final finance = financeFormProvider.finance!;

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(400),
        1: FixedColumnWidth(350),
      },
      children: [
        TableRow(
          children: [
            Container(
                width: 400,
                height: 400,
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
                child: Column(
                  children: [
                    Form(
                      key: financeFormProvider.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text('TAXES',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Divider(
                              indent: 40, endIndent: 40, color: Colors.black),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX 01 %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      initialValue:
                                          finance.tax1number.toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }
                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }
                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }
                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        finance.tax1number =
                                            double.parse(value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      initialValue: finance.tax1name,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        finance.tax1name = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX 02 %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      initialValue:
                                          finance.tax2number.toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }

                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }

                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }

                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }

                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        finance.tax2number =
                                            double.parse(value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      initialValue: finance.tax2name,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        finance.tax2name = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TAX 03 %',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      initialValue:
                                          finance.tax3number.toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TAX %';
                                        }

                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Only numbers';
                                        }

                                        if (parsedValue > 99) {
                                          return 'TAX cannot exceed 99%';
                                        }

                                        if (value.contains('.') &&
                                            value.split('.').last.length > 2) {
                                          return 'Max 2 decimal places';
                                        }

                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        finance.tax3number =
                                            double.parse(value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('TYPE',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 90, // Estableces el ancho
                                height: 80, // Estableces el alto
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      initialValue: finance.tax3name,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter TYPE';
                                        }
                                        if (value.length > 5) {
                                          return 'Max 5 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        finance.tax3name = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 150,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 200, 83, 1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      const Color.fromRGBO(177, 255, 46, 100),
                                  width: 2,
                                )),
                            child: TextButton(
                              child: Text(
                                'SAVE',
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (financeFormProvider.validForm()) {
                                  final saved = await financeFormProvider.updateTax();
                                  if (saved) {
                                    NotificationService.showSnackBa('TAXES Updated');
                                    if (!context.mounted) return;
                                    Provider.of<FinanceProvider>(context,listen: false).getFinance();
                                    NavigationService.replaceTo('/dashboard/settings/finance');
                                  } else {
                                    NotificationService.showSnackBarError(
                                        'Error: The TAXES were not updated');
                                  }
                                } else {
                                  NotificationService.showSnackBarError(
                                      'Please fill all fields correctly');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
                ),
            Container(
                height: 400,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)),
                    ]),
                child: Column(children: [
                  const SizedBox(height: 20),
                  Text(
                    '',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(height: 20),
                ])),
            Container(
                height: 400,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)),
                    ]),
                child: Column(children: [
                  const SizedBox(height: 20),
                  Text(
                    '',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                ]))
          ],
        ),
      ],
    );
  }
}
