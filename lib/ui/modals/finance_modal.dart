import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';
import 'package:web_dashboard/ui/buttons/custom_outlined_buttom.dart';
import 'package:web_dashboard/ui/labels/custom_labels.dart';

class FinanceModal extends StatefulWidget {
  final Finance? finance;

  const FinanceModal({super.key, this.finance});

  @override
  State<FinanceModal> createState() => _FinanceModalState();
}

class _FinanceModalState extends State<FinanceModal> {
  String? mainCurrencyname;
  String? mainCurrencysymbol;
  String? secondCurrencyname;
  String? secondCurrencysymbol;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final financeFormProvider = Provider.of<FinanceFormProvider>(context, listen: false);
  

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 600,
        width: 600, 
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:  const Color.fromARGB(255, 58, 60, 65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Finances Setup',
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white)
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white70),

            const SizedBox(height: 40),
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
              child: Row(
                children: [
                  Column(
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
                          style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey, // Color de fondo
                            foregroundColor: Colors.white, // Color del texto
                            textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12), // Estilo de texto
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
                              ? 'Main: $mainCurrencyname ($mainCurrencysymbol)'
                              : 'Select Main Currency'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Secondary Currency:',
                          style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey, // Color de fondo
                            foregroundColor: Colors.white, // Color del texto
                            textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12), // Estilo de texto
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
                              ? 'Secondary: $secondCurrencyname ($secondCurrencysymbol)'
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
                  const SizedBox(width: 10),
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
                                    //  initialValue: finance.tax1number.toString(),
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
                                      //initialValue: finance.tax1name,
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
                                      // initialValue:finance.tax2number.toString(),
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
                                     // initialValue: finance.tax2name,
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
                                      // initialValue: finance.tax3number.toString(),
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
                                     // initialValue: finance.tax3name,
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
                                      
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                ],
              ),
            ),
           
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              child: CustomOutlineButtom(
                onPressed: () async {
                
                },
                text: 'Save',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
